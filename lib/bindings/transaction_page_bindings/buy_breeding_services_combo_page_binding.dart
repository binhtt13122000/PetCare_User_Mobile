import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_breeding_services_combo_page_controller.dart';

class BuyBreedingServicesComboPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyBreedingServicesComboPageController>(
        () => BuyBreedingServicesComboPageController());
  }
}
