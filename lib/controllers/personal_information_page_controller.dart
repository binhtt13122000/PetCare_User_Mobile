import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';

class PersonalInfomationPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxString selectedGender =
      Get.find<AuthController>().accountModel.customerModel.gender.obs;
}
