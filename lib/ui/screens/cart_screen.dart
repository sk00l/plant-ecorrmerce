import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:plant_ecommerce/configs/extension/build_context_extension.dart';
import 'package:plant_ecommerce/modules/cart/bloc/cart_bloc.dart';

import 'package:plant_ecommerce/models/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _counter = 1;

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
            child: SizedBox(
              height: size.height * .5,
              width: size.width,
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state.cartStateEnum == CartStateEnum.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.cartStateEnum == CartStateEnum.success &&
                      state.cartModelList != null &&
                      state.cartModelList!.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<CartBloc>().add(GetCartById());
                      },
                      child: ListView.builder(
                        itemCount: state.cartModelList!.length,
                        itemBuilder: (context, index) {
                          CartModel cartItem = state.cartModelList![index];
                          return Container(
                            height: 180,
                            // margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              color: appColor.primary,
                              borderRadius: BorderRadius.circular(20),
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
                                              value: _counter,
                                              size: 30,
                                              style: CartStepperStyle(
                                                iconPlus: Icons.add,
                                                iconMinus: Icons.remove,
                                                foregroundColor: Colors.black87,
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
                                                  _counter = count;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: FaIcon(
                                    FontAwesomeIcons.leaf,
                                    size: 32,
                                    color: Color.fromARGB(255, 75, 142, 75),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state.cartStateEnum == CartStateEnum.filure &&
                      state.error != null) {
                    return Center(
                      child: Text(state.error!),
                    );
                  }
                  return Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartBloc>().add(GetCartById());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
