import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SignInVerificationOTPBodyWidget extends GetView<SignInPageController> {
  const SignInVerificationOTPBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            decorateWidget(),
            otpWidget(context: context),
          ],
        ),
      );

  Widget decorateWidget() => Image.asset(
        IMAGE_PATH + OTP_WALLPAPER_PNG,
        height: 270,
        fit: BoxFit.cover,
      );

  Widget otpWidget({required BuildContext context}) => Column(
        children: [
          verificationOTPTitleWidget(),
          SizedBox(
            height: 40,
            child: Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //otpTextFieldWidget(),
                  Expanded(
                    child: Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: controller.pin
                            .asMap()
                            .entries
                            .map((e) =>
                                pinFieldWidget(index: e.key, context: context))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  countDownWidget(),
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isInvalidOTP.value,
              child: Padding(
                padding: const EdgeInsets.only(right: 70),
                child: Text(
                  'Invalid OTP. Please try again!',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 83, 83),
                    fontSize: 10,
                    letterSpacing: 1,
                    height: 2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );

  Widget pinFieldWidget({required int index, required BuildContext context}) {
    // TextEditingController textEditingController = TextEditingController();
    return SizedBox(
      // height: 50,
      width: 35,
      child: TextFormField(
        //controller: textEditingController,
        // onSaved: (value) {
        //   if (value!.isEmpty
        //       // && controller.pin[index].isNotEmpty
        //       ) {
        //     controller.countPin.value--;
        //   } else if (value.isNotEmpty
        //       // && controller.pin[index].isEmpty
        //       ) {
        //     controller.countPin.value++;
        //   }
        //   controller.countPin.value += 1;
        //   controller.pin[index] = value;
        // },
        cursorColor: PRIMARY_COLOR,

        maxLength: 1,
        decoration: InputDecoration(
            hintText: '',
            isCollapsed: true,
            counterText: '',
            focusColor: PRIMARY_COLOR,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10)),

        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w700,
          color: PRIMARY_COLOR,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        textAlign: TextAlign.center,
        onChanged: (value) {
          bool isBack = false;
          if (value.isEmpty && controller.pin[index].isNotEmpty) {
            controller.countPin.value--;
          } else if (value.isNotEmpty && controller.pin[index].isEmpty) {
            controller.countPin.value++;
          } else if (value.isEmpty && controller.pin[index].isEmpty) {
            isBack = true;
          }

          controller.pin[index] = value;

          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else if (isBack) {
            //  FocusScope.of(context).previousFocus();
          }
          //print(value);
          controller.isInvalidOTP.value = false;
        },
      ),
    );
  }

  Widget verificationOTPTitleWidget() => Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CUSTOM_TEXT(
              'OTP Verification',
              fontWeight: FontWeight.w700,
              color: PRIMARY_COLOR,
              fontSize: 22,
              letterSpacing: 2,
              padding: const EdgeInsets.only(bottom: 10),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'An 6 digit code has been send to',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 78, 96, 121),
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                  CUSTOM_TEXT(
                    controller.selectedAreaCode +
                        ' ' +
                        controller.phoneNumber.value,
                    fontWeight: FontWeight.w700,
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget countDownWidget() => Container(
        height: 45,
        width: 60,
        alignment: Alignment.center,
        child: Obx(
          () => controller.countDownTime.value != 0
              ? Stack(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        value:
                            controller.countDownTime.value / controller.maxTime,
                        color: PRIMARY_COLOR,
                        backgroundColor: PRIMARY_LIGHT_COLOR,
                        strokeWidth: 3,
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      child: Text(
                        controller.countDownTime.value.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 78, 96, 121),
                        ),
                      ),
                    ),
                  ],
                )
              : InkWell(
                  onTap: () async {
                    await controller.auth.verifyPhoneNumber(
                        phoneNumber:
                            controller.signInPhoneNumber.replaceAll(' ', ''),
                        verificationCompleted: (phoneAuthCredential) async {},
                        verificationFailed: (verificationFailed) async {},
                        codeSent: (verificationId, resendingToken) async {
                          // controller
                          //   ..verificationId = verificationId
                          //   ..resendingToken = resendingToken
                          //   ..countDownTime.value = controller.maxTime;
                          controller
                            ..startTimer()
                            ..isWaitingSignIn.value = false;
                        },
                        forceResendingToken: controller.resendingToken,
                        codeAutoRetrievalTimeout: (verificationId) {});
                  },
                  child: const CircleAvatar(
                    backgroundColor: GREEN_COLOR,
                    child: Icon(
                      Icons.autorenew,
                      color: WHITE_COLOR,
                      size: 27,
                    ),
                  ),
                ),
        ),
      );

  // Widget otpTextFieldWidget() => Expanded(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             height: 45,
  //             child: TextFormField(
  //               cursorColor: PRIMARY_COLOR,
  //               initialValue: controller.otp.value,
  //               maxLength: 6,
  //               style: GoogleFonts.quicksand(
  //                 fontWeight: FontWeight.w500,
  //                 color: const Color.fromARGB(255, 78, 98, 124),
  //                 fontSize: 16,
  //               ),
  //               keyboardType: const TextInputType.numberWithOptions(
  //                   decimal: false, signed: false),
  //               decoration: InputDecoration(
  //                 counterText: '',
  //                 suffixIcon: Align(
  //                   widthFactor: 1,
  //                   heightFactor: 1,
  //                   child: Text(
  //                     (controller.otp.value.length).toString() + '/6',
  //                     style: GoogleFonts.quicksand(
  //                       fontWeight: FontWeight.w500,
  //                       color: const Color.fromARGB(255, 78, 98, 124),
  //                       fontSize: 13,
  //                     ),
  //                   ),
  //                 ),
  //                 enabledBorder: const OutlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: Color.fromARGB(255, 136, 154, 180),
  //                   ),
  //                 ),
  //                 focusedBorder: const OutlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: Color.fromARGB(255, 136, 154, 180),
  //                   ),
  //                 ),
  //               ),
  //               onChanged: (String? value) {
  //                 controller.otp.value = value ?? '';
  //                 controller.isInvalidOTP.value = false;
  //               },
  //             ),
  //           ),
  //           Obx(
  //             () => Expanded(
  //               child: Visibility(
  //                 visible: controller.isInvalidOTP.value,
  //                 child: Text(
  //                   'Invalid OTP. Please try again!',
  //                   style: GoogleFonts.quicksand(
  //                     fontWeight: FontWeight.w500,
  //                     color: const Color.fromARGB(255, 255, 83, 83),
  //                     fontSize: 10,
  //                     letterSpacing: 1,
  //                     height: 2,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
}
