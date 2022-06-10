import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';

class ProfilePageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isLoadingData = false.obs;
}
