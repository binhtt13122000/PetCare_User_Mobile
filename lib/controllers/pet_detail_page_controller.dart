import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class PetDetailPageController extends GetxController {
  late PetModel petModel;
  RxBool isLoadingData = false.obs;
  late RxString selectedViewType;
  List<String> viewTypes = ['Pet details', 'Pet health records'];
  RxBool isViewPetPapers = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool isOnTopScroll = false.obs;
  RxString topTitle = 'Pet Information Page'.obs;

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
