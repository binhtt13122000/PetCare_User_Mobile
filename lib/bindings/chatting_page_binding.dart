import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/chatting_page_controller.dart';

class ChattingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChattingPageController>(() => ChattingPageController());
  }
}
