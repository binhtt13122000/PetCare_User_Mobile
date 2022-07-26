// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class PetManagementPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  TextEditingController textEditingController = TextEditingController();
  late List<PetModel> petList;
  RxBool isLoadingPetList = false.obs;
  String? petStatus;
  RxString searchText = ''.obs;
  List<String> postTypeList = ['All status', 'Normal', 'In a post'];
  late RxString selectedPetStatus;
  late PetModel selectedPetModel;
  PetManagementPageController() {
    selectedPetStatus = postTypeList[0].obs;
  }
  RxBool isWaitingDeletePet = false.obs;
  RxBool isShowNotificationPopup = false.obs;
  late String notificationTitle;
  RxBool isShowConfirmPopup = false.obs;
}
