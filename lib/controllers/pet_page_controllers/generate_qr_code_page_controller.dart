import 'dart:io';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';

class GenerateQrCodeController extends GetxController {
  late int petId;
  AccountModel accountModel = Get.find<AuthController>().accountModel;

  RxBool isShowSuccessfullyPopup = false.obs;
  RxBool isWaitingCreatePet = false.obs;
  RxBool isLoadingData = false.obs;
  RxBool isWaitingLoadingData = false.obs;

  RxBool isFirstInputPetName = true.obs;
  RxString petName = ''.obs;
  RxString petDeepLink = ''.obs;
}
