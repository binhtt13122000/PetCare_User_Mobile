import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/services/other_services/firebase_messaging_services.dart';

class ProfilePageController extends GetxController {
  late String policy;
  RxBool isLoadingPolicy = false.obs;
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isLoadingData = false.obs;
  RxBool isWaitingSignOut = false.obs;
  RxBool isShowTabProfile = false.obs;
  final FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService.instance;
  late String userDeviceToken;
  late int postQuantity;
  late int petQuantity;
  late int orderQuantity;
  RxBool isShowPolicy = false.obs;
  RxBool isShowPhoneNumber = false.obs;
  setUserDeviceToken() async {
    await firebaseMessagingService.initialize();
    userDeviceToken = firebaseMessagingService.getUserDeviceToken!;
  }
}
