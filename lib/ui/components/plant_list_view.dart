import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:plant_ecommerce/modules/plant_add/bloc/plant_bloc.dart';

class PlantListViewer extends StatefulWidget {
  const PlantListViewer({super.key});

  @override
  State<PlantListViewer> createState() => _PlantListViewerState();
}

class _PlantListViewerState extends State<PlantListViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 340, // Adjust the height if needed
          child: BlocBuilder<PlantBloc, PlantState>(
            builder: (context, state) {
              if (state.plantStateEnum == PlantStateEnum.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.plantModelList != null &&
                  state.plantModelList!.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.plantModelList!.length,
                  itemBuilder: (context, index) {
                    final plant = state.plantModelList![index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: InkWell(
                        onTap: () {
                          context.go('/detailsScreen');
                        },
                        child: Container(
                          width: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 245, 245, 245),
                                    image: DecorationImage(
                                      image: NetworkImage(state
                                          .plantModelList![index].imageUrl),
                                      fit: BoxFit.fitHeight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  plant.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Indoor Plant',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$ ${plant.price}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const Spacer(),
                                    const FaIcon(
                                      FontAwesomeIcons.leaf,
                                      size: 32,
                                      color: Color.fromARGB(255, 75, 142, 75),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state.error != null) {
                return Center(
                  child: Text(state.error!),
                );
              } else {
                return const Center(
                  child: Text('No plants available'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
