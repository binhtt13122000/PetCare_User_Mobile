import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/pet_combo_detail_model/pet_combo_detail_model.dart';
import 'package:petapp_mobile/models/pet_combo_model/pet_combo_model.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';
import 'package:petapp_mobile/models/ticket_time_model/ticket_time_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PetComboDetailPageController extends GetxController {
  RxBool isShowBranchDetail = false.obs;
  //RxBool isShowSuccessfullyPopup = false.obs;
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxInt ticketId = (-1).obs;
  RxList showDescriptionIndexList = [].obs;
  RxBool isShowCalendar = false.obs;
  RxString tmpMeetingTimeText = FORMAT_DATE_TIME(
          dateTime: DateTime.now().add(const Duration(days: 1)),
          pattern: DATE_PATTERN_2)
      .obs;
  DateTime bookingServicesDate = DateTime.now().add(const Duration(days: 1));
  DateTime tmpBookingServicesDate = DateTime.now().add(const Duration(days: 1));
  RxString bookingServicesDateText = FORMAT_DATE_TIME(
          dateTime: DateTime.now().add(const Duration(days: 1)),
          pattern: DATE_PATTERN_2)
      .obs;
  RxBool isShowPickTimeWidget = false.obs;
  RxBool isLoadingBookingTicketTimeData = false.obs;
  List<TicketTimeModel> ticketTimeModelList = [];
  RxInt selectedTicketTimeIndex = (-1).obs;
  RxBool isWaitLoadingData = false.obs;
  RxBool isWaitLoadingPetServicesList = false.obs;
  RxBool isWaitLoadingDataForeGround = false.obs;
  RxBool isShowServicesStatusBarWidget = false.obs;
  RxBool isShowConfirmPopup = false.obs;
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
  RxBool isShowCreateTicketPopup = false.obs;
  late List<TicketModel> ticketModelList;

  void setTicketTimeModelList() {
    ticketTimeModelList = [];
    if (ticketModelList.isNotEmpty) {
      if (ticketModelList[0].startTime >
          selectedPetComboDetailModel.centerServiceModel.estimatedTime) {
        int tmpStartTime = 0;
        do {
          int tmpEndTime = tmpStartTime +
              selectedPetComboDetailModel.centerServiceModel.estimatedTime;
          if (tmpEndTime <= ticketModelList[0].startTime &&
              (tmpEndTime <= 300 ||
                  (tmpStartTime >= 360 && tmpEndTime <= 600))) {
            ticketTimeModelList.add(
              TicketTimeModel(startTime: tmpStartTime, endTime: tmpEndTime),
            );
          }
          tmpStartTime += 30;
        } while (tmpStartTime < ticketModelList[0].startTime);
      }
      if (600 - ticketModelList[ticketModelList.length - 1].endTime >
          selectedPetComboDetailModel.centerServiceModel.estimatedTime) {
        int tmpStartTime = ticketModelList[ticketModelList.length - 1].endTime;
        do {
          int tmpEndTime = tmpStartTime +
              selectedPetComboDetailModel.centerServiceModel.estimatedTime;
          if (tmpEndTime <= 300 || (tmpStartTime >= 360 && tmpEndTime <= 600)) {
            ticketTimeModelList.add(
              TicketTimeModel(startTime: tmpStartTime, endTime: tmpEndTime),
            );
          }
          tmpStartTime += 30;
        } while (tmpStartTime < 600);
      }
      if (ticketModelList.length > 1) {
        int index = 1;
        do {
          if (ticketModelList[index].startTime -
                  ticketModelList[index - 1].endTime >
              selectedPetComboDetailModel.centerServiceModel.estimatedTime) {
            int tmpStartTime = ticketModelList[index - 1].endTime;
            do {
              int tmpEndTime = tmpStartTime +
                  selectedPetComboDetailModel.centerServiceModel.estimatedTime;
              if (tmpEndTime <= ticketModelList[index].startTime &&
                  (tmpEndTime <= 300 ||
                      (tmpStartTime >= 360 && tmpEndTime <= 600))) {
                ticketTimeModelList.add(
                  TicketTimeModel(startTime: tmpStartTime, endTime: tmpEndTime),
                );
              }
              tmpStartTime += 30;
            } while (tmpStartTime < ticketModelList[index].startTime);
          }
          index++;
        } while (index < ticketModelList.length);
      }

      selectedTicketTimeIndex.value = ticketTimeModelList.isNotEmpty ? 0 : -1;
    } else {
      ticketTimeModelList = [];
      int tmpStartTime = 0;
      do {
        int tmpEndTime = tmpStartTime +
            selectedPetComboDetailModel.centerServiceModel.estimatedTime;
        if (tmpEndTime <= 300 || (tmpStartTime >= 360 && tmpEndTime <= 600)) {
          ticketTimeModelList.add(
            TicketTimeModel(startTime: tmpStartTime, endTime: tmpEndTime),
          );
        }

        tmpStartTime += 30;
      } while (tmpStartTime < 600);

      selectedTicketTimeIndex.value = ticketTimeModelList.isNotEmpty ? 0 : -1;
    }
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
