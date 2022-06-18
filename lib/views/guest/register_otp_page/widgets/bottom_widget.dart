import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/register_page_controller.dart';

class RegisterOTPPageBottomWidget extends GetView<RegisterPageController> {
  const RegisterOTPPageBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: InkWell(
            onTap: () async {
              if (controller.otp.value.length == 6 &&
                  controller.countDownTime.value > 0) {
                controller.isLoadingOTP.value = true;

                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: controller.verificationId,
                        smsCode: controller.otp.value);
                try {
                  controller.userCredential = await controller.auth
                      .signInWithCredential(phoneAuthCredential);

                  if (controller.userCredential.user != null) {
                    await controller.setUserDeviceToken();
                    controller.accessToken =
                        await controller.userCredential.user!.getIdToken();
                    Get.toNamed(REGISTER_USER_INFORMATION_PAGE_ROUTE);
                    controller
                      ..countDownTime.value = 0
                      ..isLoadingOTP.value = false;
                  } else {
                    controller
                      ..isLoadingOTP.value = false
                      ..isInvalidOTP.value = true;
                  }
                } on FirebaseAuthException {
                  controller
                    ..isLoadingOTP.value = false
                    ..isInvalidOTP.value = true;
                }
              }
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: controller.otp.value.length == 6 &&
                        controller.countDownTime.value > 0
                    ? PRIMARY_COLOR.withOpacity(0.9)
                    : PRIMARY_COLOR.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: controller.otp.value.length == 6 &&
                          controller.countDownTime.value > 0
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Continue To Register',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w700,
                  color: WHITE_COLOR,
                  fontSize: 15,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ),
      );
}
