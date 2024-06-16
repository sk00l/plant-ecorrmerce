import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<UserCredential?> signInWithEmailPassword(
      String email, String password);
  Future<void> signOut();
  Future<UserCredential> autoLogin();
}
