import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';

class SignInPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInPageController>(() => SignInPageController());
  }
}