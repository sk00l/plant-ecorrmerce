import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_ecommerce/modules/auth/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailLoginRepository implements AuthenticationRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  EmailLoginRepository() {
    _getSharedPreferenceInstance();
  }

  SharedPreferences? pref;

  Future<void> _getSharedPreferenceInstance() async {
    pref = await SharedPreferences.getInstance();
  }

    @override
  Future<UserCredential?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      await pref?.setString('email', email);
      await pref?.setString('password', password);

      return userCredential;
    } catch (e) {
      log('errr found');
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await pref?.remove('email');
    await pref?.remove('password');
  }

  @override
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
