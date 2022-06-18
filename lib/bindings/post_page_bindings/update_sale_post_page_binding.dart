import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_sale_post_page_controller.dart';

class UpdateSalePostPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateSalePostPageController>(
        () => UpdateSalePostPageController());
  }
}
