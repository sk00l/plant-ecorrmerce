// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  CartModel cartModel;
  AddToCartEvent({required this.cartModel});
}

class GetCartById extends CartEvent {}

class DeleteCart extends CartEvent {
  final String id;
  DeleteCart(
    this.id,
  );
}
