// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:plant_ecommerce/configs/extension/build_context_extension.dart';
import 'package:plant_ecommerce/models/cart_model.dart';
import 'package:plant_ecommerce/modules/cart/bloc/cart_bloc.dart';
import 'package:plant_ecommerce/modules/plant_add/bloc/plant_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final String plantId;
  const DetailsScreen({
    Key? key,
    required this.plantId,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    context.read<PlantBloc>().add(GetPlantById(uuid: widget.plantId));
    _rating = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColor;
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<PlantBloc, PlantState>(
      builder: (context, state) {
        if (state.plantStateEnum == PlantStateEnum.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.plantModel != null) {
          final plant = state.plantModel!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appColor.primary,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/vectors/heart2.svg'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/vectors/share1.svg'),
                ),
              ],
            ),
            body: Container(
              color: appColor.primary,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: size.height * .4,
                      width: size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(plant.imageUrl),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 300.1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                      width: size.width,
                      height: size.height * .6,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plant.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                    Symbols.kid_star,
                                    fill: 1,
                                    color: Colors.amber),
                                onRatingUpdate: (rating) {
                                  setState(
                                    () {
                                      _rating = rating;
                                    },
                                  );
                                },
                              ),
                              Text(
                                _rating.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(
                                '   ( 123 Reviews)',
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Text(
                            plant.description,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Divider(
                            color: Colors.grey[200],
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Size',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      plant.size,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Colors.grey[200],
                                  thickness: 1,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Plant',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      plant.type,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Colors.grey[200],
                                  thickness: 1,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Height',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      plant.height,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Colors.grey[200],
                                  thickness: 1,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Humidity',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      plant.humidity,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "\$ ${plant.price.toString()}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 75, 142, 75),
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                        AddToCartEvent(
                                          cartModel: CartModel(
                                            name: plant.name,
                                            description: plant.description,
                                            size: plant.size,
                                            type: plant.size,
                                            height: plant.height,
                                            humidity: plant.humidity,
                                            price: plant.price,
                                            id: '',
                                            imageUrl: plant.imageUrl,
                                            postedBy: '',
                                          ),
                                        ),
                                      );
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
                                  'Add to cart',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (state.error != null) {
          return Center(child: Text(state.error!));
        } else {
          return const Center(child: Text('No plant details available'));
        }
      },
    );
  }
}
