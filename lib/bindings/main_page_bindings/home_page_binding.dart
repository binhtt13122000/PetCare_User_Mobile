import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/home_page_controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}
