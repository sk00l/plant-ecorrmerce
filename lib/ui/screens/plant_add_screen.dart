import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_ecommerce/models/plant_model.dart';
import 'package:plant_ecommerce/modules/plant_add/bloc/plant_bloc.dart';
import 'package:plant_ecommerce/modules/plant_add/repository/plant_add_repository.dart';

class PlantAddScreen extends StatefulWidget {
  const PlantAddScreen({super.key});

  @override
  State<PlantAddScreen> createState() => _PlantAddScreenState();
}

class _PlantAddScreenState extends State<PlantAddScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final sizeController = TextEditingController();
  final plantTypeController = TextEditingController();
  final heightController = TextEditingController();
  final humudityController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Plant"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Plant Name"),
            ),
            const SizedBox(height: 16.0),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: null,
            ),
            const SizedBox(height: 16.0),
            // Plant size field (dropdown or text field)
            // DropdownButtonFormField<String>(
            //   value: _size,
            //   hint: const Text("Size"),
            //   items: plantSizes
            //       .map((size) => DropdownMenuItem(
            //             value: size,
            //             child: Text(size),
            //           ))
            //       .toList(),
            //   onChanged: (value) => setState(() => _size = value!),
            // ),
            TextField(
              controller: sizeController,
              decoration: const InputDecoration(labelText: "Size"),
              maxLines: null, // Allow multiple lines
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: plantTypeController,
              decoration: const InputDecoration(labelText: "PlantType"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            // Plant height field
            TextField(
              controller: heightController,
              decoration: const InputDecoration(labelText: "Height"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            // Plant humidity field
            TextField(
              controller: humudityController,
              decoration: const InputDecoration(labelText: "Humidity (%)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            // Plant price field
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            // Submit button
            ElevatedButton(
              onPressed: () {
                context.read<PlantBloc>().add(
                      AddPlantEvent(
                        plantModel: PlantModel(
                          name: nameController.text,
                          description: descriptionController.text,
                          size: sizeController.text,
                          type: plantTypeController.text,
                          height: heightController.text,
                          humidity: humudityController.text,
                          price: int.parse(priceController.text),
                          uuid: uuid.v4(),
                          imageUrl: '',
                        ),
                      ),
                    );
              },
              child: const Text("Add Plant"),
            ),
            BlocBuilder<PlantBloc, PlantState>(builder: (context, state) {
              if (state.imageFile == null) {
                return const SizedBox();
              }
              return Image.file(state.imageFile!);
            }),
            ElevatedButton(
              onPressed: () {
                context.read<PlantBloc>().add(PickImage());
              },
              child: const Text("Image"),
            )
          ],
        ),
      ),
    );
  }
}
