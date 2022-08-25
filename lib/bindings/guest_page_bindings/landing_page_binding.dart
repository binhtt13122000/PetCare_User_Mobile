import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/landing_page_controller.dart';

class GuestLandingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestLandingPageController());
  }
}
