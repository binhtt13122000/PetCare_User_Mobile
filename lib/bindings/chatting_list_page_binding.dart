import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/chatting_list_page_controller.dart';

class ChattingListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChattingListPageController>(() => ChattingListPageController());
  }
}
