import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';

class SignInVerificationBottomWidget extends GetView<SignInPageController> {
  const SignInVerificationBottomWidget({Key? key}) : super(key: key);

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
                AccountModel? accountModel = await controller
                    .signInWithPhoneAuthCredential(phoneAuthCredential);
                if (accountModel != null) {
                  Get.lazyPut<AuthController>(
                      () => AuthController(accountModel: accountModel),
                      fenix: true);
                  Get.offAllNamed(HOME_PAGE_ROUTE);
                } else {
                  controller.isInvalidOTP.value = true;
                }

                controller.isLoadingOTP.value = false;
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
                'Sign In',
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
