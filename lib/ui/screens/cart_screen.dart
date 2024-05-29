import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_ecommerce/modules/cart/bloc/cart_bloc.dart';

import 'package:plant_ecommerce/models/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetCartById());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
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
            child: Container(
              color: Colors.black,
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
                            height: 130,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 245, 245, 245),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: cartItem.imageUrl != null
                                              ? Image.network(cartItem.imageUrl)
                                              : const Icon(Icons
                                                  .photo_size_select_large_rounded),
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
                                              cartItem.type,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              "\$ ${cartItem.price}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
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
