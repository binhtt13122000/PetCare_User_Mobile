import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/vaccine_list_page_controller.dart';

class VaccineListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VaccineListPageController>(() => VaccineListPageController());
  }
}
