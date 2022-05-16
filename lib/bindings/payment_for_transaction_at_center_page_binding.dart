import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/payment_for_transaction_at_center_page_controller.dart';

class PaymentForTransactionAtCenterPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentForTransactionAtCenterPageController>(
        () => PaymentForTransactionAtCenterPageController());
  }
}
