import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';

class UpdatePetPageController extends GetxController {
  late PetModel petModel;
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isShowSuccessfullyPopup = false.obs;
  RxBool isWaitingUpdatePet = false.obs;
  RxBool isLoadingData = false.obs;
  RxBool isLoadingDataSpecies = false.obs;


  RxBool isFirstInputPetName = true.obs;
  RxString petName = ''.obs;

  RxList<SpeciesModel> species = <SpeciesModel>[].obs;
  RxInt selectedSpeciesId = (-1).obs;

  RxList<BreedModel> breeds = <BreedModel>[].obs;
  RxInt selectedBreedsId = (-1).obs;
  RxBool isLoadingBreedData = false.obs;

  File? avatar;
  RxString avatarUrl = ''.obs;

  RxString selectedGender = 'MALE'.obs;
  RxString selectedFertility = 'YES'.obs;

  DateTime? dateOfBirthTime;
  DateTime? tmpDateOfBirthTime;
  RxString dayOfBirthText = ''.obs;
  RxBool isDisplayCalender = false.obs;

  RxString color = ''.obs;
  RxString specialMarkings = ''.obs;
  RxString vaccineDescription = ''.obs;
  RxString description = ''.obs;
  TextEditingController textEditingNameController = TextEditingController();
  TextEditingController textEditingColorController = TextEditingController();
  TextEditingController textEditingSpecialMarkingsController = TextEditingController();
  TextEditingController textEditingVaccineInformationController = TextEditingController();
  TextEditingController textEditingDescriptionController = TextEditingController();
}
