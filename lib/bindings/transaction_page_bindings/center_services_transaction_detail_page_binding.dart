import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/center_services_transaction_detail_page_controller.dart';

class CenterServicesTransactionDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailPageController>(() => OrderDetailPageController());
  }
}
