import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';

class TicketDetailPageController extends GetxController {
  RxList<int> selectShowMorePetList = <int>[].obs;
  AccountModel accountModel = Get.find<AuthController>().accountModel;
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
  RxList<String> selectReasonCancelList = <String>[].obs;
  RxBool isWaitingUpdateTicket = false.obs;
  RxBool isShowPopupWidget = false.obs;
  late int ticketId;
  RxBool isShowConfirmPopup = false.obs;
}
