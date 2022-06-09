import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';
import 'package:petapp_mobile/models/ticket_time_model/ticket_time_model.dart';

class CreateTicketPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isLoadingData = false.obs;
  RxInt selectedDateIndex = 0.obs;
  RxBool isShowPickTimeWidget = false.obs;
  late List<TicketModel> ticketModelList;
  DateTime bookingServicesDate = DateTime.now().add(const Duration(days: 1));
  late List<BranchModel> branchModelList;
  RxInt selectBranchId = 7.obs;
  List<TicketTimeModel> ticketTimeModelList = [];
  RxInt selectedTicketTimeIndex = (-1).obs;
  RxInt totalEstimateTime = 0.obs;
  RxBool isLoadingTicketList = false.obs;
  RxList<int> selectCenterServicesIndexList = <int>[].obs;
  late List<CenterServiceModel> centerServicesModelList;
  RxBool isShowAddServices = false.obs;
  RxBool isWaitingSendTicket = false.obs;
  RxBool isShowPopupWidget = false.obs;
  int? ticketId;

  void setTicketTimeModelList() {
    ticketTimeModelList = [];
    if (ticketModelList.isNotEmpty) {
      if (ticketModelList[0].startTime! > totalEstimateTime.value) {
        int tmpStartTime = 0;
        do {
          int tmpEndTime = tmpStartTime + totalEstimateTime.value;
          if (tmpEndTime <= ticketModelList[0].startTime! &&
              (tmpEndTime <= 300 ||
                  (tmpStartTime >= 360 && tmpEndTime <= 600))) {
            ticketTimeModelList.add(
              TicketTimeModel(startTime: tmpStartTime, endTime: tmpEndTime),
            );
          }
          tmpStartTime += 30;
        } while (tmpStartTime < ticketModelList[0].startTime!);
      }
      if (600 - ticketModelList[ticketModelList.length - 1].endTime! >
          totalEstimateTime.value) {
        int tmpStartTime = ticketModelList[ticketModelList.length - 1].endTime!;
        do {
          int tmpEndTime = tmpStartTime + totalEstimateTime.value;
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
          if (ticketModelList[index].startTime! -
                  ticketModelList[index - 1].endTime! >
              totalEstimateTime.value) {
            int tmpStartTime = ticketModelList[index - 1].endTime!;
            do {
              int tmpEndTime = tmpStartTime + totalEstimateTime.value;
              if (tmpEndTime <= ticketModelList[index].startTime! &&
                  (tmpEndTime <= 300 ||
                      (tmpStartTime >= 360 && tmpEndTime <= 600))) {
                ticketTimeModelList.add(
                  TicketTimeModel(startTime: tmpStartTime, endTime: tmpEndTime),
                );
              }
              tmpStartTime += 30;
            } while (tmpStartTime < ticketModelList[index].startTime!);
          }
          index++;
        } while (index < ticketModelList.length);
      }

      selectedTicketTimeIndex.value = ticketTimeModelList.isNotEmpty ? 0 : -1;
    } else {
      ticketTimeModelList = [];
      int tmpStartTime = 0;
      do {
        int tmpEndTime = tmpStartTime + totalEstimateTime.value;
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
}
