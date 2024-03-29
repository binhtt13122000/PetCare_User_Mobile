import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/notification_page_controller.dart';

class NotificationPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationPageController>(() => NotificationPageController());
  }
}
