import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_post_page_controller.dart';

class UpdatePostPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePostPageController>(() => UpdatePostPageController());
  }
}
