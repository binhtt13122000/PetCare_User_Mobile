import 'dart:io';

import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';

class PersonalInfomationPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxString firstName = Get.find<AuthController>().accountModel.customerModel.firstName.obs;
  RxString lastName = Get.find<AuthController>().accountModel.customerModel.lastName.obs;
  RxString email = Get.find<AuthController>().accountModel.customerModel.email.obs;
  RxBool isLoadingUpdateProfile = false.obs;
  RxString avatarfilePathCharacter = Get.find<AuthController>().accountModel.customerModel.avatarCharacter.obs;
  RxString avatarfilePath = Get.find<AuthController>().accountModel.customerModel.avatar.obs;
  File? avatarFile;
  Rx<String?> address = Get.find<AuthController>().accountModel.customerModel.address.obs;

  RxString selectedGender =
      Get.find<AuthController>().accountModel.customerModel.gender.obs;
}
