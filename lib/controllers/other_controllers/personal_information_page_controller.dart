import 'dart:io';

import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';

class PersonalInformationPageController extends GetxController {
  CustomerModel? customerModel;
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isShowConfirmPopup = false.obs;
  late RxString firstName;
  late RxString lastName;
  late RxString email;
  late RxString avatarCharacter;
  RxString avatarFilePath = ''.obs;
  late RxString address;
  late RxString selectedGender;
  late RxString bankName;
  late RxString bankBranch;
  late RxString bankCode;
  RxBool isShowNotificationPopup = false.obs;
  RxBool isLoadingUpdateProfile = false.obs;
  File? avatarFile;

  PersonalInformationPageController() {
    firstName = accountModel.customerModel.firstName.obs;
    lastName = accountModel.customerModel.lastName.obs;
    email = accountModel.customerModel.email.obs;
    avatarCharacter = accountModel.customerModel.avatarCharacter.obs;
    address = (accountModel.customerModel.address ?? '').obs;
    selectedGender = accountModel.customerModel.gender.obs;
    bankName = (accountModel.customerModel.bankName ?? '').obs;
    bankCode = (accountModel.customerModel.bankCode ?? '').obs;
    bankBranch = (accountModel.customerModel.bankBranch ?? '').obs;
  }
}
