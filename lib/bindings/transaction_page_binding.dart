import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_page_controller.dart';

class TransactionPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionPageController>(() => TransactionPageController());
  }
}