import 'package:get/get.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';

class TicketDetailPageController extends GetxController {
  late TicketModel ticketModel;
  RxBool isLoadingData = false.obs;
  RxBool isShowMoreOptions = false.obs;
}
