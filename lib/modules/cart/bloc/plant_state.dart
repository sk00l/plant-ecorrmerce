part of 'plant_bloc.dart';

sealed class PlantState extends Equatable {
  const PlantState();
  
  @override
  List<Object> get props => [];
}

final class PlantInitial extends PlantState {}
