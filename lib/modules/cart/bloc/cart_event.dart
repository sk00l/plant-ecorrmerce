part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  CartModel cartModel;
  AddToCartEvent({required this.cartModel});
}

class GetCartById extends CartEvent {}
