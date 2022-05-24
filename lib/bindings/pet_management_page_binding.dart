import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';

class PetManagementPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetManagementPageController>(
        () => PetManagementPageController(),
        fenix: true);
  }
}
