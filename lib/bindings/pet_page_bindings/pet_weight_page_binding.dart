import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_weight_page_controller.dart';

class PetWeightPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetWeightPageController>(() => PetWeightPageController());
  }
}
