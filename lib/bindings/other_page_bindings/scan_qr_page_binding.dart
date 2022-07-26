import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/scan_qr_page_controller.dart';

class ScanQRPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanQRPageController>(() => ScanQRPageController());
  }
}
