import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_combo_model/pet_combo_model.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class PetDetailPageController extends GetxController {
  RxBool isLoadingPetCombo = false.obs;
  RxBool isLoadingHealthRecord = false.obs;
  RxBool isLoadingPetDetail = false.obs;
  late List<PetComboModel> petComboModelList;
  late PetModel petModel;
  RxBool isLoadingData = false.obs;
  late RxString selectedViewType;
  List<String> viewTypes = ['Pet details', 'Health records', 'Services combo'];
  RxBool isViewPetPapers = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool isOnTopScroll = false.obs;
  RxString topTitle = 'Pet Information Page'.obs;
  late List<PetHealthRecordModel> vaccinesList;
  late List<PetHealthRecordModel> dewormingList;
  late List<PetHealthRecordModel> removeTicksList;
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
        topTitle.value = 'Pet Information Page';
      }
    });
  }
}
