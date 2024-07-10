import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plant_ecommerce/configs/router/app_router.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> onBgMessage() async {
  //!background ma stay out
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    FCMNotificationHelper.handleNotificationClick(initialMessage.data);
  }
}

class FCMNotificationHelper {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await requestPermission(); //!1 to user
    listenTokenRefresh(); //!2send backend
    initializeLocalNotification(); //!for android foreground

    //!3 Get any messages which caused the application to open from
    // a terminated state.
    var initialMessage = await messaging.getInitialMessage();

    if (initialMessage != null) {
      handleNotificationClick(initialMessage.data);
    }

    // This listener is responsible for handling messages that are received while
    //! the application is in the foreground.
    //It allows the app to process and display notifications or perform actions
    // based on the content of the message.
    /// When the app is open and running in the foreground,
    /// this listener will be triggered upon receiving a new FCM message.
    /// This means it can be used to update the UI, show a local notification,
    /// or perform any other action that should happen immediately in response
    /// to the message.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      showLocalNotification(message);

      // ios
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    });

    // handle events where a user taps on a notification that was delivered while
    //! the app was in the background or not running. It allows the app to respond
    // to user interaction with the notification, such as opening a specific screen
    // or performing an action related to the notification's content.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationClick(message.data);
    });
  }

  Future<void> listenTokenRefresh() async {
    //!after expire
    messaging.onTokenRefresh.listen((token) {
      registerToken(token);
    });
    final token = await getDeviceToken(); //!token aagaya
    if (token != null) {
      log(token.toString());
      registerToken(token);
    }
  }

  void registerToken(String token) {
    //! register token to the server.
    log('''
======================================
TOKEN: ${token.toString()}
======================================
''');
  }

  static void handleNotificationClick(Map<String, dynamic> data) {
    log('''
Handling click notifications.
======================================
${data.toString()}
======================================
''');

    if (data.containsKey("chat")) {
      AppRouter.router.go("cartpage");
      // AppRouter.router.go("/login/chat/${data["chat"]}");
    } else {
      AppRouter.router.go("/");
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  Future<NotificationSettings> requestPermission() async {
    return await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
  }

  Future<void> initializeLocalNotification() async {
    // Create Settings for Android and ios
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    const iosSettings = DarwinInitializationSettings();

    //! Apply Created Settings to initialise them
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: iosSettings);

    // initialise localNotificationsPlugin
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
      //!triggered when notif pressed from dragdown payload ma
      if (response.payload != null) {
        handleNotificationClick(jsonDecode(response.payload!));
      }
    });
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    //! ayyo notif
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      message.notification?.android?.channelId ?? "Notification Channel",
      "Notification Channel",
      channelDescription: "Notification Channel Description",
      importance: Importance.max,
      priority: Priority.high,
    );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(),
    );
    log(message.data.toString(), name: "Notification DATAAA:");
    await flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: jsonEncode(
          message.data), //!aayera string ma ani pachi decoded line 146
    );
  }
}
