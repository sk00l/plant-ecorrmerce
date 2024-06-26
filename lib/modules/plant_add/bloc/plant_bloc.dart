import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plant_ecommerce/configs/di/service_locator.dart';
import 'package:plant_ecommerce/models/plant_model.dart';
import 'package:plant_ecommerce/modules/plant_add/repository/plant_add_repository.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantBloc() : super(const PlantState()) {
    on<AddPlantEvent>((event, emit) async {
      try {
        emit(state.copyWith(error: null));
        var imageURL = await plantAddRepositorty.uploadImage(state.imageFile!);
        event.plantModel = event.plantModel.copyWith(imageUrl: imageURL);

        await plantAddRepositorty.addPlant(event.plantModel);
        emit(state.copyWith(plantStateEnum: PlantStateEnum.success));
      } on FirebaseException catch (e) {
        emit(state.copyWith(
            plantStateEnum: PlantStateEnum.filure,
            error: "${e.code.toString()} ${e.message}"));
      } catch (e) {
        emit(state.copyWith(
            plantStateEnum: PlantStateEnum.filure, error: e.toString()));
      }
    });

    on<GetPlantEvent>((event, emit) async {
      try {
        await emit.forEach(plantAddRepositorty.getRealtimeStreamData(),
            onData: (data) {
          return state.copyWith(
            plantStateEnum: PlantStateEnum.success,
            plantModelList: data,
          );
        }, onError: (e, _) {
          return state.copyWith(
            plantStateEnum: PlantStateEnum.filure,
          );
        });
      } catch (e) {
        emit(state.copyWith(
            plantStateEnum: PlantStateEnum.filure, error: e.toString()));
      }
    });

    on<GetPlantById>((event, emit) async {
      try {
        emit(state.copyWith(plantStateEnum: PlantStateEnum.loading));
        var res = await plantAddRepositorty.getPlantsById(event.uuid);
        emit(state.copyWith(
          plantStateEnum: PlantStateEnum.success,
          plantModel: res,
        ));
      } catch (e) {
        emit(state.copyWith(
            plantStateEnum: PlantStateEnum.filure, error: e.toString()));
      }
    });

    on<DeletePlantById>((event, emit) async {
      try {
        emit(state.copyWith(plantStateEnum: PlantStateEnum.loading));
        await plantAddRepositorty.deleteEvent(event.uuid);

        // add(GetEvent());
      } catch (e) {
        emit(state.copyWith(
            plantStateEnum: PlantStateEnum.filure, error: e.toString()));
      }
    });

    on<PickImage>((event, emit) async {
      try {
        emit(state.copyWith(plantStateEnum: PlantStateEnum.imagePicking));
        var res = await plantAddRepositorty.getFileFromPicker();
        emit(state.copyWith(
          plantStateEnum: PlantStateEnum.imagePicked,
          imageFile: res,
        ));
      } catch (e) {
        emit(state.copyWith(
            plantStateEnum: PlantStateEnum.filure, error: e.toString()));
      }
    });
  }

  final PlantAddRepositorty plantAddRepositorty =
      getIt.get<PlantAddRepositorty>();
}
