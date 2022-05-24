// ignore_for_file: avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
//import 'package:tflite/tflite.dart';

class CreatePetPageController extends GetxController {
  RxBool isShowSuccessfullyPopup = false.obs;
  File? avatar;
  RxString avatarUrl = ''.obs;
  bool isFirstInputName = true;
  RxString petName = ''.obs;
  RxString description = ''.obs;
  RxBool isDisplayCalender = false.obs;
  RxString selectedGender = 'MALE'.obs;
  RxString selectedFertility = 'YES'.obs;
  DateTime? dateOfBirthTime;
  DateTime? tmpDateOfBirthTime;
  RxString dayOfBirthText = ''.obs;
  RxMap<int, RxInt> selectedBreedMap = <int, RxInt>{}.obs;
  RxMap<int, RxList<BreedModel>> breedsMap = <int, RxList<BreedModel>>{}.obs;
  late List<SpeciesModel> species;
  RxInt selectedSpeciesId = 1.obs;
  AccountModel accountModel = Get.find<SignInPageController>().accountModel!;
  RxBool isShowLoadingWidget = false.obs;
}
