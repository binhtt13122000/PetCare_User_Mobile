import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/sale_post_detail_page_controller.dart';

class SalePostDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalePostDetailPageController>(
        () => SalePostDetailPageController());
  }
}
