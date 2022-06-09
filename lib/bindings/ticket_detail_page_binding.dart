import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/ticket_detail_page_controller.dart';

class TicketDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketDetailPageController>(() => TicketDetailPageController());
  }
}
