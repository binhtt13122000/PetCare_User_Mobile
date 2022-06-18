import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_combo_detail_model/pet_combo_detail_model.dart';
import 'package:petapp_mobile/models/pet_combo_model/pet_combo_model.dart';

class PetComboDetailPageController extends GetxController {
  RxBool isWaitLoadingData = false.obs;
  RxBool isWaitLoadingPetServicesList = false.obs;
  RxBool isWaitLoadingDataForeGround = false.obs;
  RxBool isShowServicesStatusBarWidget = false.obs;
  RxBool isShowPopup = false.obs;
  RxBool isShowNotificationPopup = false.obs;
  String notificationTitle = '';
  RxBool isShowRatingPopup = false.obs;
  late PetComboDetailModel selectedPetComboDetailModel;
  ScrollController scrollController = ScrollController();
  late PetComboModel petComboModel;
  RxString petComboStatus = ''.obs;
  List<String> servicesStatus = [
    'Waiting',
    'Available',
    'Completed',
    'Expired'
  ];
  late RxString selectServicesStatus;
  RxList<String> quickFeedBackList = <String>[].obs;
  RxString ratingText = 'Rating'.obs;
  RxInt selectedStar = 0.obs;
  String reviewContent = '';

  PetComboDetailPageController() {
    selectServicesStatus = servicesStatus[0].obs;
    scrollController.addListener(() {
      isShowServicesStatusBarWidget.value =
          scrollController.position.pixels >= 305;
    });
  }

  updateRatingText() {
    switch (selectedStar.value) {
      case 0:
        ratingText.value = 'Rating';
        break;
      case 1:
        ratingText.value = 'Very bad';
        break;
      case 2:
        ratingText.value = 'Bad';
        break;
      case 3:
        ratingText.value = 'Temporarily\ngood';
        break;
      case 4:
        ratingText.value = 'Good';
        break;
      case 5:
        ratingText.value = 'Perfect';
        break;
      default:
    }
  }
}
