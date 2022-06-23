import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/breeding_transaction_model/breeding_transaction_model.dart';

class BreedingTransactionDetailPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  late int breedingTransactionId;
  RxBool isShowCancelPopup = false.obs;
  RxBool isShowMoreOptions = false.obs;
  late BreedingTransactionModel breedingTransactionModel;
  RxBool isWaitingLoadingInitData = false.obs;
  RxString paymentUrl = ''.obs;
  RxBool isShowPopup = false.obs;
  RxBool isShowReviewPopup = false.obs;
  RxInt selectedStar = 0.obs;
  RxString ratingText = 'Rating'.obs;
  RxList<String> quickFeedBackList = <String>[].obs;
  RxList<String> quickCancelList = <String>[].obs;
  String reviewContent = '';
  RxString cancelDescription = ''.obs;
  RxBool isShowCancelResultPopup = false.obs;
  List<String> viewTabList = ['Transaction details', 'Breeding services'];
  RxString selectedViewTab = 'Transaction details'.obs;
  ScrollController scrollController = ScrollController();
  RxBool isShowViewTypeTabWidget = false.obs;
  RxBool isWaitingForeground = false.obs;
  String popupTitle = '';
  RxBool isWaitingLoadingDataInBreedingTab = false.obs;
  RxBool isWaitingLoadingTransactionDetailTab = false.obs;
  RxBool isShowBreedingServicesBottom = false.obs;
  RxBool isShowTransactionDetailBottom = false.obs;
  RxBool isShowConfirmPopup = false.obs;
  late String confirmPopupTitle;
  RxBool isShowMoreOptionWidget = false.obs;
  late Function() onTapOk;
  late String reviewType;

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

  BreedingTransactionDetailPageController() {
    scrollController.addListener(() {
      isShowViewTypeTabWidget.value =
          scrollController.position.pixels > 200 ? true : false;
    });
  }
}
