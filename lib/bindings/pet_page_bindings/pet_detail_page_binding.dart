import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';

class PetDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetDetailPageController>(() => PetDetailPageController());
  }
}