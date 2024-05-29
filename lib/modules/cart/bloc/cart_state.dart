// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

enum CartStateEnum {
  initial,
  loading,
  success,
  filure,
}

class CartState extends Equatable {
  final CartStateEnum? cartStateEnum;
  final List<CartModel>? cartModelList;
  final CartModel? cartModel;
  final String? error;
  const CartState({
    this.cartStateEnum,
    this.cartModelList,
    this.cartModel,
    this.error,
  });

  @override
  List<Object?> get props => [cartStateEnum, cartModelList, cartModel, error];

  CartState copyWith({
    CartStateEnum? cartStateEnum,
    List<CartModel>? cartModelList,
    CartModel? cartModel,
    String? error,
  }) {
    return CartState(
      cartStateEnum: cartStateEnum ?? this.cartStateEnum,
      cartModelList: cartModelList ?? this.cartModelList,
      cartModel: cartModel ?? this.cartModel,
      error: error ?? this.error,
    );
  }
}
