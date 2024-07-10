import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_ecommerce/configs/di/fcm_notification_helper.dart';
import 'package:plant_ecommerce/configs/di/service_locator.dart';
import 'package:plant_ecommerce/configs/router/app_router.dart';
import 'package:plant_ecommerce/firebase_options.dart';
import 'package:plant_ecommerce/modules/auth/email%20login/bloc/login_bloc.dart';
import 'package:plant_ecommerce/modules/auth/email%20signup/bloc/signup_bloc.dart';
import 'package:plant_ecommerce/modules/cart/bloc/cart_bloc.dart';
import 'package:plant_ecommerce/modules/plant_add/bloc/plant_bloc.dart';
import 'package:plant_ecommerce/themes/bloc/theme_bloc.dart';
import 'package:plant_ecommerce/themes/configs/app_theme.dart';

Future<void> main() async {
  runApp(
    SizedBox(
      child: Image.asset(
        'assets/images/spl.png',
        fit: BoxFit.cover,
      ),
    ),
  );
  await Future.delayed(const Duration(seconds: 2));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setup();
  getIt.get<FCMNotificationHelper>().init();
  onBgMessage();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => PlantBloc()
            ..add(
              GetPlantEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => LoginBloc()
            ..add(
              AutoLoginRequested(),
            ),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(GetCartById()),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return MaterialApp.router(
            routerConfig: AppRouter.router,
            theme: state is ThemeChanged
                ? state.themeMode == ThemeMode.dark
                    ? AppTheme.darkTheme()
                    : AppTheme.lightTheme()
                : AppTheme.lightTheme());
      }),
    );
  }
}
