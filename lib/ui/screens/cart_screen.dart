import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_ecommerce/modules/plant_add/bloc/plant_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
              child: BlocBuilder<PlantBloc, PlantState>(
                builder: (context, state) {
                  if (state.plantStateEnum == PlantStateEnum.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.plantModelList != null &&
                      state.plantModelList!.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<PlantBloc>(context)
                            .add(GetPlantEvent());
                      },
                      child: ListView.builder(
                        itemCount: state.plantModelList!.length,
                        itemBuilder: (context, index) {
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
                                          child: state.plantModelList![index]
                                                      .imageUrl !=
                                                  null
                                              ? Image.network(state
                                                  .plantModelList![index]
                                                  .imageUrl)
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
                                              state.plantModelList![index].name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.plantModelList![index].type,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              "\$ ${state.plantModelList![index].price}",
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
                  } else if (state.error != null) {
                    return Center(
                      child: Text(state.error!),
                    );
                  }
                  return Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<PlantBloc>().add(GetPlantEvent());
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
