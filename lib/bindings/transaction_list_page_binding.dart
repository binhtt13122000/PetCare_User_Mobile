import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_list_page_controller.dart';

class TransactionListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionListPageController>(
        () => TransactionListPageController());
  }
}
