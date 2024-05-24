// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'plant_bloc.dart';

enum PlantStateEnum { initial, loading, success, filure }

class PlantState extends Equatable {
  final PlantStateEnum? plantStateEnum;
  final List<PlantModel>? plantModelList;
  final PlantModel? plantModel;
  final String? error;
  const PlantState({
    this.plantStateEnum,
    this.plantModelList,
    this.plantModel,
    this.error,
  });
  @override
  List<Object?> get props =>
      [plantStateEnum, plantModelList, plantModel, error];

  PlantState copyWith({
    PlantStateEnum? plantStateEnum,
    List<PlantModel>? plantModelList,
    PlantModel? plantModel,
    String? error,
  }) {
    return PlantState(
      plantStateEnum: plantStateEnum ?? this.plantStateEnum,
      plantModelList: plantModelList ?? this.plantModelList,
      plantModel: plantModel ?? this.plantModel,
      error: error ?? this.error,
    );
  }
}
