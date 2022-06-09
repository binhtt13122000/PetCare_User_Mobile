import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';

class ActionPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isLoadingData = false.obs;
  TicketModel? ticketModel;
  RxInt ticketId = (-1).obs;
}
