import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/purchase_posts_page_controller.dart';

class PurchasePostsPageBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<PurchasePostsPageController>(() => PurchasePostsPageController());
  }
}