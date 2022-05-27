import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/sale_transaction_detail_page_controller.dart';

class SaleTransactionDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaleTransactionDetailPageController());
  }
}
