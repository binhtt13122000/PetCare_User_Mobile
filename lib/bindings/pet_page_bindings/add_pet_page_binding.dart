import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/add_pet_page_controller.dart';

class AddPetPagePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePetPageController>(() => CreatePetPageController(),
        fenix: true);
  }
}
