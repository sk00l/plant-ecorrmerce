import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plant_ecommerce/configs/extension/build_context_extension.dart';
import 'package:plant_ecommerce/models/cart_model.dart';
import 'package:plant_ecommerce/modules/cart/bloc/cart_bloc.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;
    return Scaffold(
      body: BlocListener<CartBloc, CartState>(
        listenWhen: (previous, current) =>
            previous.cartStateEnum != current.cartStateEnum ||
            previous.error != current.error,
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Item Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state.cartStateEnum == CartStateEnum.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state.cartStateEnum ==
                                CartStateEnum.success &&
                            state.cartModelList != null &&
                            state.cartModelList!.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                              // scrollDirection: Axis.vertical,
                              itemCount: state.cartModelList?.length,
                              itemBuilder: (context, index) {
                                CartModel cartItem =
                                    state.cartModelList![index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 60,
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
                                                  fit: BoxFit.contain,
                                                  alignment:
                                                      Alignment.topCenter,
                                                )
                                              : const Icon(Icons
                                                  .photo_size_select_large_rounded),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartItem.name,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            state.cartModelList![index].type,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: appColor.primarytext,
                                            ),
                                          ),
                                          Text(
                                            "\$${cartItem.price}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('No events available.'),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
