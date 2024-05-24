part of 'plant_bloc.dart';

abstract class PlantEvent {}

class AddPlantEvent extends PlantEvent {
  final PlantModel plantModel;
  AddPlantEvent({required this.plantModel});
}

class GetPlantEvent extends PlantEvent {}

class GetPlantById extends PlantEvent {
  final String uuid;
  GetPlantById({required this.uuid});
}

class DeletePlantById extends PlantEvent {
  final String uuid;
  DeletePlantById({required this.uuid});
}
