import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/deworming_history_page_controller.dart';

class DewormingHistoryPageBiding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DewormingHistoryPageController>(
        () => DewormingHistoryPageController());
  }
}
