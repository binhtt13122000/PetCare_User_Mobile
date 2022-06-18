import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';

class BuyServicesComboPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyServicesComboPageController>(
        () => BuyServicesComboPageController());
  }
}
