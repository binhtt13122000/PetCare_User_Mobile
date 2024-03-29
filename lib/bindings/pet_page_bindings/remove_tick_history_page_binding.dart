import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/remove_ticks_history_page_controller.dart';

class RemoveTicksHistoryPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoveTicksHistoryPageController>(
        () => RemoveTicksHistoryPageController());
  }
}
