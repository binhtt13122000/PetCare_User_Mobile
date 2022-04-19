// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';

class CreatePostPageController extends GetxController {
  RxList<File> evidences = <File>[].obs;
  RxList<String> evidencesPath = <String>[].obs;
  RxList<File> healthChecker = <File>[].obs;
  RxList<String> healthCheckerPath = <String>[].obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxInt price = 0.obs;
  RxString moneyReceived = ''.obs;
  RxInt deposit = 0.obs;
  RxString selectedTicketType = 'PURCHASE'.obs;
  bool isFirstInputPrice = true;
  bool isFirstInputTitle = true;
  bool isFirstInputDescription = true;
  RxBool isShowPetFilter = false.obs;
  bool isFirstSelectedPet = true;

  RxInt selectedSpeciesId = 1.obs;
  late List<SpeciesModel> species;

  Map<int, int> selectedBreedMap = <int, int>{};
  Map<int, List<BreedModel>> breedsMap = <int, List<BreedModel>>{};

  late RxList<PetModel> pets;
  late RxInt selectedPetId = 0.obs;

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final tmpImage = File(image.path);

      evidences.add(tmpImage);
      evidencesPath.add(tmpImage.path);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final tmpImage = File(image.path);

      evidences.add(tmpImage);
      evidencesPath.add(tmpImage.path);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
