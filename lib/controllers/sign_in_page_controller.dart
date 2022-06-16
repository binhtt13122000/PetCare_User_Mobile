// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/services/firebase_messaging_services.dart';
import 'package:petapp_mobile/services/account_services.dart';

class SignInPageController extends GetxController {
  //!new
  RxBool isUsedPhoneNumber = true.obs;
  TextEditingController textEditingController = TextEditingController();
  late int? resendingToken;
  RxBool isInvalidOTP = false.obs;
  late String signInPhoneNumber;
  //!new

  RxBool isWaitingSignIn = false.obs;
  RxBool isLoadingOTP = false.obs;

  late RxInt countDownTime = 0.obs;
  int maxTime = 60;

  RxString phoneNumber = ''.obs;
  bool isFirstInputPhoneNumber = true;
  RxString otp = ''.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  late String verificationId;

  final FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService.instance;
  late String userDeviceToken;

  RxString selectedAreaCode = '+84'.obs;
  Map<String, String> areaCodeMap = {
    VIETNAM_PNG: '+84',
    UNITED_STATES_PNG: '+1',
  };

  Future<AccountModel?> signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final UserCredential authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        String idToken = await authCredential.user!.getIdToken();
        await setUserDeviceToken();
        return await AccountService.signIn(
            idToken: idToken, userDeviceToken: userDeviceToken);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (_) {
      return null;
    }
  }

  startTimer() {
    countDownTime.value = maxTime;
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
