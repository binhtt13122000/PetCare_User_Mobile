// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:tflite/tflite.dart';

class AddPetPageController extends GetxController {
  File? avatar;
  RxString avatarUrl = ''.obs;

  RxString ticketType = 'Sell Pets'.obs;

  bool isFirstInputName = true;
  RxString petName = ''.obs;

  RxString description = ''.obs;
  bool isFirstInputDescription = true;

  ValueNotifier<GraphQLClient> graphqlClient = GRAPHQL_CLIENT;

  RxBool isDisplayCalender = false.obs;

  RxString selectedGender = 'MALE'.obs;
  RxString selectedFertility = 'Yes'.obs;
  DateTime? tmpDOB;
  DateTime? dOB;
  RxString dOBText = ''.obs;
  String ageRange = '';

  RxMap<int, RxInt> selectedBreedMap = <int, RxInt>{}.obs;
  RxMap<int, RxList<BreedModel>> breedsMap = <int, RxList<BreedModel>>{}.obs;

  late List<SpeciesModel> species;
  RxInt selectedSpeciesId = 1.obs;

  late RxString selectedDogBloodGroup;
  List<String> dogBloodGroup = [
    'DEA-1.1',
    'DEA-1.2',
    'DEA-3',
    'DEA-4',
    'DEA-5',
    'DEA-7',
  ];

  AddPetPageController() {
    selectedDogBloodGroup = dogBloodGroup[0].obs;
  }

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final tmpImage = File(image.path);
      avatarUrl.value = image.path;
      avatar = tmpImage;
    } on PlatformException catch (e) {
      print(e.toString());
    } finally {
      var output = await Tflite.runModelOnImage(
          path: avatarUrl.value,
          numResults: 2,
          threshold: 0.5,
          imageMean: 127.5,
          imageStd: 127.5);

      tmp = output;
      update();
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final tmpImage = File(image.path);

      avatarUrl.value = image.path;
      avatar = tmpImage;
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  List<dynamic>? tmp;
}
