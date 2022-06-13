import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/update_pet_page_controller.dart';

class UpdatePetPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePetPageController>(() => UpdatePetPageController());
  }
}
