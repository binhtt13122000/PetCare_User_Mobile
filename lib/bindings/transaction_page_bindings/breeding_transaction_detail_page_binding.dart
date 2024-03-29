import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';

class BreedingTransactionDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BreedingTransactionDetailPageController());
  }
}
