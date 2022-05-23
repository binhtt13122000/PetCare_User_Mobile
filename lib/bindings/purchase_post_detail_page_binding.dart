import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/purchase_post_detail_page_controller.dart';

class PurchasePostDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchasePostDetailPageController>(
        () => PurchasePostDetailPageController());
  }
}
