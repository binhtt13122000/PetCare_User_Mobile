import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/register_page_controller.dart';
import 'package:petapp_mobile/services/account_services.dart';

class RegisterPhoneNumberPageBottomWidget
    extends GetView<RegisterPageController> {
  const RegisterPhoneNumberPageBottomWidget({Key? key}) : super(key: key);

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
                    !controller.isUsedPhoneNumber.value
                ? () async {
                    controller.isUsedPhoneNumber.value =
                        await AccountService.checkPhoneNumber(
                      phoneNumber: (controller.selectedAreaCode +
                              controller.phoneNumber.value)
                          .replaceAll(' ', ''),
                    );
                    if (!controller.isUsedPhoneNumber.value) {
                      controller.isLoadingPhoneCredential.value = true;
                      if (controller.countDownTime.value > 0) {
                        Get.toNamed(VERIFICATION_OTP_PAGE_ROUTE);
                        controller.isLoadingPhoneCredential.value = false;
                      } else {
                        await controller.auth.verifyPhoneNumber(
                            phoneNumber: (controller.selectedAreaCode.value +
                                    controller.phoneNumber.value)
                                .replaceAll(' ', ''),
                            verificationCompleted: (phoneAuthCredential) async {
                              controller.isLoadingPhoneCredential.value = false;
                            },
                            verificationFailed: (verificationFailed) async {
                              controller.isLoadingPhoneCredential.value = false;
                            },
                            codeSent: (verificationId, resendingToken) async {
                              controller.isLoadingPhoneCredential.value = false;
                              controller.verificationId = verificationId;
                              controller.countDownTime.value =
                                  controller.maxTime;
                              Get.toNamed(REGISTER_OTP_PAGE_ROUTE);
                              controller.startTimer();
                            },
                            codeAutoRetrievalTimeout: (verificationId) {
                              controller.isLoadingPhoneCredential.value = false;
                            });
                      }
                    }
                  }
                : () {},
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: controller.phoneNumber.value.isNotEmpty &&
                        !controller.isUsedPhoneNumber.value
                    ? PRIMARY_COLOR.withOpacity(0.9)
                    : PRIMARY_COLOR.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: controller.phoneNumber.value.isNotEmpty &&
                          !controller.isUsedPhoneNumber.value
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
