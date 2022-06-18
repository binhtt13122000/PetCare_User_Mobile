import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/payment_for_center_services_transaction_page_controller.dart';

class PaymentForCenterServicesTransactionPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentForCenterServicesTransactionPageController>(
        () => PaymentForCenterServicesTransactionPageController());
  }
}
