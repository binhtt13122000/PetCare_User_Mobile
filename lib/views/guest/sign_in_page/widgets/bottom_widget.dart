import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/services/other_services/auth_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SignInBottomWidget extends GetView<SignInPageController> {
  const SignInBottomWidget({Key? key}) : super(key: key);

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
            onTap: () async {
              if (controller.phoneNumber.value.length == 12 &&
                  controller.isUsedPhoneNumber.value) {
                controller
                  ..isWaitingSignIn.value = true
                  ..signInPhoneNumber =
                      controller.selectedAreaCode + controller.phoneNumber.value
                  ..isUsedPhoneNumber.value =
                      await AuthService.checkPhoneNumber(
                          phoneNumber:
                              controller.signInPhoneNumber.replaceAll(' ', ''));
                if (controller.isUsedPhoneNumber.value) {
                  await controller.auth.verifyPhoneNumber(
                      phoneNumber:
                          controller.signInPhoneNumber.replaceAll(' ', ''),
                      verificationCompleted: (phoneAuthCredential) async {},
                      verificationFailed: (verificationFailed) async {},
                      codeSent: (verificationId, resendingToken) async {
                        controller
                          ..verificationId = verificationId
                          ..resendingToken = resendingToken;

                        Get.toNamed(SIGN_IN_VERIFICATION_OTP_PAGE_ROUTE);

                        controller
                          ..startTimer()
                          ..isWaitingSignIn.value = false;
                      },
                      codeAutoRetrievalTimeout: (verificationId) {});
                } else {
                  controller.isWaitingSignIn.value = false;
                }
              }
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: controller.phoneNumber.value.length == 12 &&
                        controller.isUsedPhoneNumber.value
                    ? PRIMARY_COLOR.withOpacity(0.9)
                    : PRIMARY_COLOR.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: controller.phoneNumber.value.length == 12 &&
                          controller.isUsedPhoneNumber.value
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CUSTOM_TEXT(
              'You are new? Go to ',
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
              fontSize: 11,
              letterSpacing: 1.5,
            ),
            InkWell(
              onTap: () => Get.offNamed(REGISTER_PHONE_NUMBER_PAGE_ROUTE),
              child: CUSTOM_TEXT(
                'Register now',
                fontWeight: FontWeight.w700,
                color: PRIMARY_COLOR,
                fontSize: 11,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      );
}
