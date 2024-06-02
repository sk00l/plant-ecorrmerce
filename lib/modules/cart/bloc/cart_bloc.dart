import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_ecommerce/configs/locator/service_locator.dart';
import 'package:plant_ecommerce/models/cart_model.dart';
import 'package:plant_ecommerce/modules/cart/repository/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCartEvent>((event, emit) async {
      try {
        emit(state.copyWith(error: null));
        var currentUser = FirebaseAuth.instance.currentUser!.uid;
        var id = uuid.v4();
        event.cartModel =
            event.cartModel.copyWith(postedBy: currentUser, id: id);
        await cartRepository.saveCart(event.cartModel);
      } on FirebaseException catch (e) {
        emit(state.copyWith(error: e.toString()));
      } on Exception catch (e) {
        log(e.toString());
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    });
    on<GetCartById>((event, emit) async {
      try {
        emit(state.copyWith(cartStateEnum: CartStateEnum.loading, error: null));
        final cartList = await cartRepository.getCartList();
        emit(state.copyWith(
            cartStateEnum: CartStateEnum.success, cartModelList: cartList));
      } on FirebaseException catch (e) {
        emit(state.copyWith(
            cartStateEnum: CartStateEnum.filure, error: e.toString()));
      } on Exception catch (e) {
        emit(state.copyWith(
            cartStateEnum: CartStateEnum.filure, error: e.toString()));
      }
    });
  }

  final CartRepository cartRepository = getIt.get<CartRepository>();
}
