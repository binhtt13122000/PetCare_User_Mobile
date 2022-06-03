import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/post_detail_page_controller.dart';

class PostDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailPageController>(() => PostDetailPageController());
  }
}
