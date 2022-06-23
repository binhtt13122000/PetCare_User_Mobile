import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/create_ticket_page_controller.dart';

class CreateTicketPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTicketPageController>(() => CreateTicketPageController());
  }
}
