import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/action_page_controller.dart';

class ActionPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActionPageController>(() => ActionPageController());
  }
}
