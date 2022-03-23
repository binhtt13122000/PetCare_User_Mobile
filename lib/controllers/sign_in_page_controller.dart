import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';

class SignInPageController extends GetxController {
  RxBool isLoadingPhoneCredential = false.obs;
  RxBool isLoadingOTP = false.obs;
  RxString phoneNumber = '901605667'.obs;
  bool isFirstInputPhoneNumber = true;
  bool isFirstInputOTP = true;
  RxString otp = ''.obs;
  late String verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxString areaCode = '+84'.obs;
  late RxInt countDownTime = 0.obs;
  int maxTime = 60;
  RxInt accountID = 1.obs;

  Map<String, String> areaCodeMap = {
    VIETNAM_PNG: '+84',
    UNITED_STATES_PNG: '+1',
  };

  signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    isLoadingPhoneCredential.value = true;
    try {
      final UserCredential authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      isLoadingPhoneCredential.value = false;
      if (authCredential.user != null) {
        Get.offAndToNamed(HOME_PAGE_ROUNTER);
      }
    } on FirebaseAuthException catch (e) {
      isLoadingPhoneCredential.value = false;
    }
  }

  startTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        countDownTime > 0 ? countDownTime.value-- : timer.cancel();
      },
    );
  }
}
