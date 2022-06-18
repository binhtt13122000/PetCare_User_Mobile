import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/register_page_controller.dart';

class RegisterPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPageController>(() => RegisterPageController());
  }
}
