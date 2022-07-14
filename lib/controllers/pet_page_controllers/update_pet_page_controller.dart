import 'dart:io';

import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class UpdatePetPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isShowSuccessfullyPopup = false.obs;
  RxBool isWaitingUpdatePet = false.obs;
  RxBool isLoadingData = false.obs;
  RxBool isFirstInputPetName = true.obs;
  RxString petName = ''.obs;
  File? avatar;
  RxString selectedGender = 'MALE'.obs;
  RxString selectedFertility = 'YES'.obs;
  DateTime? dateOfBirthTime;
  DateTime? tmpDateOfBirthTime;
  RxString dayOfBirthText = ''.obs;
  RxString tmpDayOfBirthTimeText = ''.obs;
  RxBool isShowCalendar = false.obs;
  RxString color = ''.obs;
  RxString description = ''.obs;
  late int petId;
  late PetModel petModel;
  RxBool isShowConfirmPopup = false.obs;
}
