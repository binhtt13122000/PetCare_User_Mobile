import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/pet_combo_model/pet_combo_model.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PetDetailPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  late int petId;
  RxBool isShowNotificationPopup = false.obs;
  RxBool isWaitingDeletePet = false.obs;
  RxBool isShowMoreOptionWidget = false.obs;
  RxBool isLoadingPetCombo = false.obs;
  RxBool isLoadingHealthRecord = false.obs;
  RxBool isLoadingPetDetail = false.obs;
  late List<PetComboModel> petComboModelList;
  RxBool isShowConfirmPopup = false.obs;
  late PetModel petModel;
  RxBool isLoadingData = false.obs;
  late RxString selectedViewType;
  List<String> viewTypes = ['Pet details', 'Health records', 'Services combo'];
  RxBool isViewPetPapers = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool isOnTopScroll = false.obs;
  RxString topTitle = 'Pet Details Page'.obs;
  late List<PetHealthRecordModel> vaccinesList;
  late List<PetHealthRecordModel> dewormingList;
  late List<PetHealthRecordModel> removeTicksList;

  final RefreshController refreshController = RefreshController();
  sortDewormingList() {
    dewormingList
        .sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  }

  sortVaccinesList() {
    vaccinesList.sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  }

  sortRemoveTicksList() {
    removeTicksList
        .sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  }

  PetDetailPageController() {
    selectedViewType = viewTypes[0].obs;
    scrollController.addListener(() {
      if (scrollController.position.pixels >= 195.3) {
        isOnTopScroll.value = true;
        topTitle.value =
            '${petModel.name} (${petModel.breedModel!.name} - ${petModel.breedModel!.speciesModel!.name})';
      } else {
        isOnTopScroll.value = false;
        topTitle.value = 'Pet Details Page';
      }
    });
  }
}
