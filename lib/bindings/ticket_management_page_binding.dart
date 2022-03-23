import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/controllers/ticket_management_page_controller.dart';

class TicketManagementPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketManagementPageController>(
        () => TicketManagementPageController());
  }
}
