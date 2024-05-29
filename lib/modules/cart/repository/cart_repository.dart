import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:plant_ecommerce/models/cart_model.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveCart(CartModel cartModel) async {
    try {
      await _firestore
          .collection('cart')
          .doc(cartModel.id)
          .set(cartModel.toJson());
      log("cart saved successfully");
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  Future<List<CartModel>?> getCartList() async {
    List<CartModel> cartList = [];
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('cart')
          .where('postedBy', isEqualTo: _auth.currentUser!.uid)
          .get();

      cartList = querySnapshot.docs
          .map((doc) => CartModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return cartList;
    } on FirebaseException catch (e) {
      log(e.toString());
    }
    return cartList;
  }
}
