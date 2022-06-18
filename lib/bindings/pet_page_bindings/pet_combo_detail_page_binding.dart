import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_combo_detail_page_controller.dart';

class PetComboDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetComboDetailPageController>(
        () => PetComboDetailPageController());
  }
}
