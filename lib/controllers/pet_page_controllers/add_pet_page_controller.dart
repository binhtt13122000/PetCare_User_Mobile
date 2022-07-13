import 'dart:io';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';

class CreatePetPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;

  RxBool isShowSuccessfullyPopup = false.obs;
  RxBool isWaitingCreatePet = false.obs;
  RxBool isLoadingData = false.obs;

  RxBool isFirstInputPetName = true.obs;
  RxString petName = ''.obs;

  late List<SpeciesModel> species;
  RxInt selectedSpeciesId = (-1).obs;

  late List<BreedModel> breeds;
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
  // RxString specialMarkings = ''.obs;
  // RxString vaccineDescription = ''.obs;
  RxString description = ''.obs;
}
