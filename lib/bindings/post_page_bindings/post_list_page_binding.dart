import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_list_page_controller.dart';

class PostsListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostListPageController>(() => PostListPageController());
  }
}
