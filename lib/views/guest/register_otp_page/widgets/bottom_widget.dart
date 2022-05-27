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
  Widget build(BuildContext context) => Column(
        children: [
          continueButtonWidget(),
          bottomWidget(),
        ],
      );

  Widget continueButtonWidget() => Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: InkWell(
            onTap: controller.phoneNumber.value.isNotEmpty &&
                    controller.countDownTime.value > 0
                ? () async {
                    controller.isLoadingOTP.value = true;
                    controller.phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: controller.verificationId,
                            smsCode: controller.otp.value);
                    controller.isFirstInputOTP.value = true;
                    try {
                      controller.userCredential = await controller.auth
                          .signInWithCredential(controller.phoneAuthCredential);

                      if (controller.userCredential.user != null) {
                        await controller.setUserDeviceToken();
                        controller.accessToken =
                            await controller.userCredential.user!.getIdToken();
                        print('uuuuuuuuuuuu:' + controller.accessToken);
                      }
                      Get.toNamed(REGISTER_USER_INFORMATION_PAGE_ROUTE);
                    } on FirebaseAuthException {
                      controller.isLoadingOTP.value = false;
                      controller.isInvalidOTP.value = true;
                    }
                  }
                : () {},
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: controller.phoneNumber.value.isNotEmpty &&
                        controller.countDownTime.value > 0
                    ? PRIMARY_COLOR.withOpacity(0.9)
                    : PRIMARY_COLOR.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: controller.phoneNumber.value.isNotEmpty &&
                          controller.countDownTime.value > 0
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Continue',
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

  Widget bottomWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Joined us before? Back to ',
            style: GoogleFonts.quicksand(
              color: const Color.fromARGB(255, 109, 122, 155),
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
            children: const [
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: PRIMARY_COLOR,
                ),
              ),
            ],
          ),
        ),
      );
}
