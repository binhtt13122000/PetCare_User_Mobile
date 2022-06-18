import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/profile_page_controller.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilePageController());
  }
}
