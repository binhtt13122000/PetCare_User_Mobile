import 'package:get/get.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';

class TicketDetailPageController extends GetxController {
  late TicketModel ticketModel;
  RxBool isLoadingData = false.obs;
  RxBool isShowCancelPopup = false.obs;
  RxString cancelTicketReason = ''.obs;
  List<String> quickReasonCancelList = [
    'I\'m busy',
    'Change services',
    'Change branch',
    'Pet is good'
  ];
  RxList selectReasonCancelList = <String>[].obs;
}
