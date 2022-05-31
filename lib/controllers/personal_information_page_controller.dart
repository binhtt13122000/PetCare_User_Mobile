import 'dart:io';

import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';

class PersonalInformationPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  late RxString firstName;
  late RxString lastName;
  late RxString email;
  late RxString avatarCharacter;
  late RxString avatarfilePath;
  late Rx<String> address;
  late RxString selectedGender;

  RxBool isLoadingUpdateProfile = false.obs;
  File? avatarFile;

  PersonalInformationPageController() {
    firstName = accountModel.customerModel.firstName.obs;
    lastName = accountModel.customerModel.lastName.obs;
    email = accountModel.customerModel.email.obs;
    avatarCharacter = accountModel.customerModel.avatarCharacter.obs;
    avatarfilePath = (accountModel.customerModel.avatar ?? '').obs;
    address = (accountModel.customerModel.address ?? '').obs;
    selectedGender = accountModel.customerModel.gender.obs;
  }
}
