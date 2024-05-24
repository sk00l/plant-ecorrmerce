import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:plant_ecommerce/models/plant_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'dart:developer';

var uuid = const Uuid();

class PlantAddRepositorty {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addPlant(PlantModel plantModel) async {
    CollectionReference collectionReference = _firestore.collection('plants');
    // plantModel = plantModel.copyWith(imageUrl: await uploadImage());
    await collectionReference.doc(plantModel.uuid).set(plantModel.toMap());
  }

  Future<List<PlantModel>?> getPlants() async {
    CollectionReference collectionReference = _firestore.collection('plants');
    QuerySnapshot querySnapshot = await collectionReference.get();
    var list = querySnapshot.docs
        .map((e) => PlantModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    return list;
  }

  Future<PlantModel?> getPlantsById(String uuid) async {
    CollectionReference collectionReference = _firestore.collection('plants');
    var res = await collectionReference.doc(uuid).get();
    return PlantModel.fromMap(res.data() as Map<String, dynamic>);
  }

  Future<void> deleteEvent(String uuid) async {
    CollectionReference cr = _firestore.collection('plants');
    await cr.doc(uuid).delete();
  }

  Stream<List<PlantModel>> getRealtimeStreamData() {
    CollectionReference cr = _firestore.collection('plants');
    return cr.snapshots().map((plant) {
      return plant.docs
          .map((e) => PlantModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<String> uploadImage(File imageFile) async {
    Reference ref = _storage
        .ref('plants')
        .child('plant_images/${imageFile.path.split('/').last}');

    var res = await ref.putFile(imageFile);
    var url = await res.ref.getDownloadURL();
    return url;
  }

  Future<File> getFileFromPicker() async {
    FilePickerResult? pickedImage = await FilePicker.platform.pickFiles();
    if (pickedImage == null) {
      throw Exception('No image selected');
    }

    File imageFile = File(pickedImage.files.single.path!);

    return imageFile;
  }
}
