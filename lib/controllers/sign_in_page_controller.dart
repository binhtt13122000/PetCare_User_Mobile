// ignore_for_file: avoid_print

import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/services/firebase_messaging_services.dart';
import 'package:petapp_mobile/services/account_services.dart';

class SignInPageController extends GetxController {
  RxBool isLoadingPhoneCredential = false.obs;
  RxBool isLoadingOTP = false.obs;

  late RxInt countDownTime = 0.obs;
  int maxTime = 60;

  RxString phoneNumber = '901605667'.obs;
  bool isFirstInputPhoneNumber = true;

  bool isFirstInputOTP = true;
  RxString otp = ''.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService.instance;
  late String userDeviceToken;
  AccountModel? accountModel;

  late String verificationId;
  RxString selectedAreaCode = '+84'.obs;
  Map<String, String> areaCodeMap = {
    VIETNAM_PNG: '+84',
    UNITED_STATES_PNG: '+1',
  };

  signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    isLoadingPhoneCredential.value = true;
    try {
      Get.offAndToNamed(HOME_PAGE_ROUNTER);

      final UserCredential authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      isLoadingPhoneCredential.value = false;
      String idToken = await authCredential.user!.getIdToken();
      if (authCredential.user != null) {
        await setUserDeviceToken();
        print('userDeviceToken' + userDeviceToken);
        AccountService.signIn(
            idToken: idToken, userDeviceToken: userDeviceToken);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
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

  setUserDeviceToken() async {
    await firebaseMessagingService.initialize();
    userDeviceToken = firebaseMessagingService.getUserDeviceToken!;
  }
}
