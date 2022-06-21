import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/generate_qr_code_page_controller.dart';

class GenerateQrCodePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateQrCodeController>(() => GenerateQrCodeController(),
        fenix: true);
  }
}
