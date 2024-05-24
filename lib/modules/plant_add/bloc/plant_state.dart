// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'plant_bloc.dart';

enum PlantStateEnum {
  initial,
  loading,
  success,
  filure,
  imagePicked,
  imagePicking
}

class PlantState extends Equatable {
  final PlantStateEnum? plantStateEnum;
  final List<PlantModel>? plantModelList;
  final PlantModel? plantModel;
  final String? error;
  final File? imageFile;
  const PlantState({
    this.plantStateEnum,
    this.plantModelList,
    this.plantModel,
    this.error,
    this.imageFile,
  });
  @override
  List<Object?> get props =>
      [plantStateEnum, plantModelList, plantModel, error, imageFile];

  PlantState copyWith({
    PlantStateEnum? plantStateEnum,
    List<PlantModel>? plantModelList,
    PlantModel? plantModel,
    String? error,
    File? imageFile,
  }) {
    return PlantState(
      plantStateEnum: plantStateEnum ?? this.plantStateEnum,
      plantModelList: plantModelList ?? this.plantModelList,
      plantModel: plantModel ?? this.plantModel,
      error: error ?? this.error,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}
