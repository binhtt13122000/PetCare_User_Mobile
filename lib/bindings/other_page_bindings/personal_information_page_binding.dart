import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/personal_information_page_controller.dart';

class PersonalInformationPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInformationPageController>(
        () => PersonalInformationPageController());
  }
}
