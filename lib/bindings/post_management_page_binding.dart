import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/post_management_page_controller.dart';

class PostManagementPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostManagementPageController>(
        () => PostManagementPageController());
  }
}
