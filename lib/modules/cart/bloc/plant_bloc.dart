import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantBloc() : super(PlantInitial()) {
    on<PlantEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
