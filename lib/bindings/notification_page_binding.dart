import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/notification_page_controller.dart';
import 'package:petapp_mobile/views/customer/notification_page/notification_page.dart';

class NotificationPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationPageController>(() => NotificationPageController());
  }
}
