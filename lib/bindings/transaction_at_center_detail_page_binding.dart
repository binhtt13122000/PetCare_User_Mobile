import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_at_center_detail_page_controller.dart';

class TransactionAtCenterDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionAtCenterDetailPageController>(
        () => TransactionAtCenterDetailPageController());
  }
}
