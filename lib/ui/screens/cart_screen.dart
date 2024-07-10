// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:plant_ecommerce/configs/extension/build_context_extension.dart';
import 'package:plant_ecommerce/modules/cart/bloc/cart_bloc.dart';

import 'package:plant_ecommerce/models/cart_model.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<int, ShakeAnimationController> _shakeControllers = {};
  final Map<int, int> _itemCounters = {};
  final Map<int, bool> _itemTapped = {};

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetCartById());
  }

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor.primary,
        title: const Center(
          child: Text(
            'My Cart',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              color: appColor.primary,
              height: size.height * .6,
              width: size.width,
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state.cartStateEnum == CartStateEnum.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.cartStateEnum == CartStateEnum.success &&
                      state.cartModelList != null &&
                      state.cartModelList!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.cartModelList!.length,
                      itemBuilder: (context, index) {
                        CartModel cartItem = state.cartModelList![index];

                        _shakeControllers.putIfAbsent(
                            index, () => ShakeAnimationController());
                        _itemCounters.putIfAbsent(index, () => 1);
                        _itemTapped.putIfAbsent(index, () => false);

                        return ShakeAnimationWidget(
                          shakeAnimationController: _shakeControllers[index]!,
                          shakeAnimationType: ShakeAnimationType.SkewShake,
                          isForward: false,
                          shakeCount: 0,
                          shakeRange: 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _itemTapped[index] = !_itemTapped[index]!;
                              });
                              if (_shakeControllers[index]!.animationRunging) {
                                _shakeControllers[index]!.stop();
                              } else {
                                _shakeControllers[index]!.start(shakeCount: 0);
                              }
                            },
                            onTapCancel: () {
                              setState(() {
                                _itemTapped[index] = false;
                              });
                              _shakeControllers[index]!.stop();
                            },
                            child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                color: appColor.primary,
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 135,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                color: appColor.primary,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: cartItem.imageUrl != null
                                                    ? Image.network(
                                                        cartItem.imageUrl,
                                                        fit: BoxFit.cover,
                                                        alignment:
                                                            Alignment.topCenter,
                                                      )
                                                    : const Icon(Icons
                                                        .photo_size_select_large_rounded),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cartItem.name,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Size: ${cartItem.type}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "\$ ${cartItem.price}.00",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              CartStepperInt(
                                                value: _itemCounters[index]!,
                                                size: 30,
                                                style: CartStepperStyle(
                                                  iconPlus: Icons.add,
                                                  iconMinus: Icons.remove,
                                                  foregroundColor:
                                                      Colors.black87,
                                                  activeForegroundColor:
                                                      Colors.black87,
                                                  activeBackgroundColor:
                                                      appColor.primary,
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  radius:
                                                      const Radius.circular(8),
                                                  elevation: 0,
                                                  buttonAspectRatio: 1,
                                                ),
                                                didChangeCount: (count) {
                                                  setState(() {
                                                    _itemCounters[index] =
                                                        count;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: _itemTapped[index]!
                                        ? IconButton(
                                            onPressed: () {
                                              _shakeControllers[index]!.stop();
                                              context.read<CartBloc>().add(
                                                  DeleteCart(state
                                                      .cartModelList![index]
                                                      .id));
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 32,
                                              color: Colors.red,
                                            ),
                                          )
                                        : const FaIcon(
                                            FontAwesomeIcons.leaf,
                                            size: 32,
                                            color: Color.fromARGB(
                                                255, 75, 142, 75),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state.cartStateEnum == CartStateEnum.filure &&
                      state.error != null) {
                    return Center(
                      child: Text(state.error!),
                    );
                  }
                  return const Text('No plants available');
                },
              ),
            ),
          ),
          Positioned(
              top: 380,
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .48,
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state.cartStateEnum == CartStateEnum.success &&
                        state.cartModelList != null) {
                      double totalPrice = state.cartModelList!
                          .fold(0, (sum, item) => sum + item.price);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Item Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "\$ ${totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Item Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "\$ ${totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              context.go('/cartPage/checkoutPage');
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 75, 142, 75),
                              minimumSize: const Size(double.infinity, 60),
                            ),
                            child: const Text(
                              'Proceed to checkout',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              )),
        ],
      ),
    );
  }
}
