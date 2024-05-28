import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_ecommerce/configs/locator/service_locator.dart';
import 'package:plant_ecommerce/data/app_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailLoginRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AppPreference? pref = getIt.get<AppPreference>();

  Future<void> _getSharedPreferenceInstance() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<UserCredential?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

pref.saveUser(email, passworfd);

      return userCredential;
    } catch (e) {
      log('errr found');
      log(e.toString());
    }
    return null;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await pref?.remove('email');
    await pref?.remove('password');
  }

  Future<UserCredential> autoLogin() async {
    await _getSharedPreferenceInstance();
    var email = pref?.getString('email');
    var password = pref?.getString('password');

    if (email != null && password != null) {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_NO_CREDENTIALS',
        message: 'No saved credentials found.',
      );
    }
  }
}
