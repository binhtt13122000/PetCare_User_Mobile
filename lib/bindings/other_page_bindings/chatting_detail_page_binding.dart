import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/chatting_detail_page_controller.dart';

class ChattingDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChattingDetailPageController>(
        () => ChattingDetailPageController());
  }
}
