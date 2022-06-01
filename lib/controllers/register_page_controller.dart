import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/services/firebase_messaging_services.dart';

class RegisterPageController extends GetxController {
  RxString firstName = ''.obs;
  RxBool isFirstInputFirstName = true.obs;

  RxString lastName = ''.obs;
  RxBool isFirstInputLastName = true.obs;

  RxString gender = 'MALE'.obs;

  RxString phoneNumber = ''.obs;
  RxBool isFirstInputPhoneNumber = true.obs;
  RxBool isUsedPhoneNumber = false.obs;

  RxString otp = ''.obs;
  RxBool isFirstInputOTP = true.obs;
  RxBool isInvalidOTP = false.obs;
  RxString email = ''.obs;

  RxString address = ''.obs;
  RxBool isSelectPickImageType = false.obs;
  RxString avatarFilePath = ''.obs;
  File? avatarFile;
  RxString selectedAreaCode = '+84'.obs;
  Map<String, String> areaCodeMap = {
    VIETNAM_PNG: '+84',
    UNITED_STATES_PNG: '+1',
  };

  FirebaseAuth auth = FirebaseAuth.instance;
  late String verificationId;

  RxBool isLoadingPhoneCredential = false.obs;
  RxBool isLoadingOTP = false.obs;

  RxInt countDownTime = 0.obs;
  int maxTime = 60;

  RxBool isLoadingRegister = false.obs;

  final FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService.instance;
  late String userDeviceToken;
  AccountModel? accountModel;

  late PhoneAuthCredential phoneAuthCredential;
  late UserCredential userCredential;
  late String accessToken;

  // Future<AccountModel?> signInWithPhoneAuthCredential(
  //     PhoneAuthCredential phoneAuthCredential) async {
  //   isLoadingPhoneCredential.value = true;
  //   try {
  //     Get.offAndToNamed(HOME_PAGE_ROUNTER);

  //     final UserCredential authCredential =
  //         await auth.signInWithCredential(phoneAuthCredential);
  //     isLoadingPhoneCredential.value = false;
  //     String idToken = await authCredential.user!.getIdToken();
  //     if (authCredential.user != null) {
  //       await setUserDeviceToken();
  //       return await AccountService.signIn(
  //           idToken: idToken, userDeviceToken: userDeviceToken);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     isLoadingPhoneCredential.value = false;
  //   }
  //   return null;
  // }

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
