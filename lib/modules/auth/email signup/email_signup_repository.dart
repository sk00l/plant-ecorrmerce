import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_ecommerce/models/user_details.dart';

class EmailSignUpRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUserWithEmailPassword(
      String email, String password, String fname, String lname) async {
    try {
      final UserCredential response = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = response.user;
      if (user == null) {
        throw Exception("user is null");
      }

      await saveUser(UserDetails(
          uid: user.uid,
          email: email,
          password: password,
          fname: fname,
          lname: lname));
    } on FirebaseAuthException catch (e) {
      print("exception has occured $e");
    }
  }

  Future<void> saveUser(UserDetails userDetails) async {
    try {
      await firestore
          .collection('user')
          .doc(userDetails.uid)
          .set(userDetails.toMap());
    } catch (e) {
      print(e);
    }
  }
}
