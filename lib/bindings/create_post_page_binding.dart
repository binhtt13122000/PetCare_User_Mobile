import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';

class CreatePostPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostPageController>(() => CreatePostPageController());
  }
}
