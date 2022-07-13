import 'dart:async';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';

class GenerateQrCodeController extends GetxController {
  late int petId;
  AccountModel accountModel = Get.find<AuthController>().accountModel;

  RxBool isShowSuccessfullyPopup = false.obs;
  RxBool isWaitingCreatePet = false.obs;
  RxBool isLoadingData = false.obs;
  RxBool isWaitingLoadingData = false.obs;
  RxInt countDownTime = 0.obs;
  int maxTime = 60;

  RxBool isFirstInputPetName = true.obs;
  RxString petName = ''.obs;
  RxString petDeepLink = ''.obs;
  late Timer timerUpdate;

  startTimer() {
    countDownTime.value = maxTime;
    timerUpdate = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (countDownTime > 0) {
          countDownTime.value--;
        } else {
          timer.cancel();
          update();
        }
      },
    );
  }
}
