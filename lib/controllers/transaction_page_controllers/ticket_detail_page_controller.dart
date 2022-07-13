import 'package:get/get.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';

class TicketDetailPageController extends GetxController {
  //*Notification
  RxBool isShowNotificationPopup = false.obs;
  bool isSuccessNotification = true;
  String notificationContent = '';
  Function()? onTapNotification;
  //*Notification
  late TicketModel ticketModel;
  RxBool isLoadingData = false.obs;
  RxBool isShowCancelPopup = false.obs;
  RxString cancelTicketReason = ''.obs;
  RxBool isShowBranchDetail = false.obs;
  List<String> quickReasonCancelList = [
    'I\'m busy',
    'Change services',
    'Change branch',
    'Pet is good'
  ];
  RxList selectReasonCancelList = <String>[].obs;
  RxBool isWaitingUpdateTicket = false.obs;
  RxBool isShowPopupWidget = false.obs;
  late int ticketId;
}
