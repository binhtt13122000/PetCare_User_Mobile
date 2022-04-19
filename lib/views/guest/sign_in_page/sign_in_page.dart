import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignInPage extends GetView<SignInPageController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 80,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //!back button
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: PRIMARY_LIGHT_COLOR,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            ICON_PATH + BACK_SVG,
                            color: PRIMARY_COLOR,
                            height: 15,
                          ),
                        ),
                      ),
                      //!app logo
                      Row(
                        children: [
                          SvgPicture.asset(
                            ICON_PATH + PET_LOGO_SVG,
                            color: PRIMARY_COLOR,
                            height: 29,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            'iU Petshop',
                            style: GoogleFonts.satisfy(
                              textStyle: const TextStyle(color: PRIMARY_COLOR),
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      //!Sign in title
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          left: 40,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign In',
                              style: GoogleFonts.itim(
                                textStyle:
                                    const TextStyle(color: PRIMARY_COLOR),
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                height: 1,
                              ),
                            ),
                            Text(
                              'Enter your registered phone number to sign in',
                              style: GoogleFonts.itim(
                                textStyle:
                                    const TextStyle(color: DARK_GREY_COLOR),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Row(
                          children: [
                            //!area code dropdown button
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 4,
                                ),
                                child: DropdownButton<String>(
                                  value: controller.selectedAreaCode.value,
                                  style: GoogleFonts.itim(
                                    color: PRIMARY_COLOR,
                                    fontSize: 15,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: PRIMARY_COLOR,
                                  ),
                                  onChanged: (String? value) {
                                    controller.selectedAreaCode.value = value!;
                                  },
                                  items: controller.areaCodeMap.entries
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                IMAGE_PATH + e.key,
                                                height: 30,
                                              ),
                                              Text(' ' + e.value),
                                            ],
                                          ),
                                          value: e.value,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            //!phone number text field
                            Expanded(
                              child: Obx(
                                () => TextFormField(
                                  cursorColor: PRIMARY_COLOR,
                                  initialValue: controller.phoneNumber.value,
                                  style: GoogleFonts.itim(
                                    fontSize: 25,
                                    color: PRIMARY_COLOR,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLength: 20,
                                  decoration: controller
                                          .phoneNumber.value.isEmpty
                                      ? const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: -15),
                                          errorText:
                                              'The field phone number is required',
                                          suffixIcon: Icon(
                                            Icons.error,
                                            color: Color.fromARGB(
                                                255, 241, 99, 88),
                                            size: 20,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: PRIMARY_COLOR,
                                              width: 2,
                                            ),
                                          ),
                                        )
                                      : const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: -15),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: PRIMARY_COLOR,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                  onChanged: (String? value) {
                                    controller.phoneNumber.value = value!;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        child: MaterialButton(
                          color: PRIMARY_LIGHT_COLOR,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue',
                                style: GoogleFonts.quicksand(
                                  color: PRIMARY_COLOR,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            controller.isLoadingPhoneCredential.value = true;
                            if (controller.countDownTime.value > 0) {
                              Get.toNamed(VERIFICATION_OTP_PAGE_ROUNTER);
                              controller.isLoadingPhoneCredential.value = false;
                            } else {
                              await controller.auth.verifyPhoneNumber(
                                  phoneNumber:
                                      controller.selectedAreaCode.value +
                                          controller.phoneNumber.value,
                                  verificationCompleted:
                                      (phoneAuthCredential) async {
                                    controller.isLoadingPhoneCredential.value =
                                        false;
                                    controller.signInWithPhoneAuthCredential(
                                        phoneAuthCredential);
                                    //Get.toNamed(VERIFICATION_OTP_PAGE_ROUNTER);
                                    //print(1);
                                  },
                                  verificationFailed:
                                      (verificationFailed) async {
                                    controller.isLoadingPhoneCredential.value =
                                        false;
                                    //Get.toNamed(VERIFICATION_OTP_PAGE_ROUNTER);
                                    //print('2' + verificationFailed.toString());
                                  },
                                  codeSent:
                                      (verificationId, resendingToken) async {
                                    controller.isLoadingPhoneCredential.value =
                                        false;
                                    controller.verificationId = verificationId;
                                    controller.countDownTime.value =
                                        controller.maxTime;
                                    Get.toNamed(VERIFICATION_OTP_PAGE_ROUNTER);
                                    controller.startTimer();
                                  },
                                  codeAutoRetrievalTimeout: (verificationId) {
                                    //Get.toNamed(VERIFICATION_OTP_PAGE_ROUNTER);
                                    //print(4);
                                    controller.isLoadingPhoneCredential.value =
                                        false;
                                  });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Obx(
              () => controller.isLoadingPhoneCredential.value
                  ? Container(
                      color: const Color.fromARGB(75, 249, 236, 253),
                      child: const SpinKitSpinningLines(
                        color: PRIMARY_COLOR,
                        size: 150,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
