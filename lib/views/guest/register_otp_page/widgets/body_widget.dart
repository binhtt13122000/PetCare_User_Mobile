import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/register_page_controller.dart';

class RegisterOTPPageBodyWidget extends GetView<RegisterPageController> {
  const RegisterOTPPageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            decorateWidget(),
            otpWidget(),
          ],
        ),
      );

  Widget decorateWidget() => Image.asset(
        IMAGE_PATH + OTP_WALLPAPER_PNG,
        height: 270,
        fit: BoxFit.cover,
      );

  Widget otpWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25, bottom: 10),
            child: Row(
              children: [
                Text(
                  'OTP Verification',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700,
                    color: PRIMARY_COLOR,
                    fontSize: 22,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'An 6 digit code has been send to \n${(controller.selectedAreaCode + controller.phoneNumber.value).replaceAll(' ', '')}',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 96, 121),
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 75,
            child: Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  otpTextFieldWidget(),
                  countDownWidget(),
                ],
              ),
            ),
          ),
        ],
      );

  Widget countDownWidget() => Container(
        height: 45,
        width: 60,
        alignment: Alignment.center,
        child: Obx(
          () => Stack(
            children: [
              Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  value: controller.countDownTime.value / controller.maxTime,
                  color: PRIMARY_LIGHT_COLOR,
                  backgroundColor: PRIMARY_COLOR,
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
          ),
        ),
      );

  Widget otpTextFieldWidget() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45,
              child: TextFormField(
                cursorColor: controller.otp.value.isEmpty &&
                        !controller.isFirstInputOTP.value
                    ? const Color.fromARGB(255, 255, 83, 83)
                    : PRIMARY_COLOR,
                initialValue: controller.otp.value,
                maxLength: 6,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 78, 98, 124),
                  fontSize: 16,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(
                      r'[0-9]',
                    ),
                  ),
                ],
                decoration: (controller.otp.value.isEmpty &&
                            !controller.isFirstInputOTP.value) ||
                        controller.isInvalidOTP.value
                    ? const InputDecoration(
                        counterText: '',
                        suffixIcon: Align(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: Icon(
                            Icons.error,
                            color: Color.fromARGB(255, 255, 83, 83),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 83, 83),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 83, 83),
                          ),
                        ),
                      )
                    : InputDecoration(
                        counterText: '',
                        suffixIcon: Align(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: Text(
                            (controller.otp.value.length).toString() + '/6',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 78, 98, 124),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 136, 154, 180),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 136, 154, 180),
                          ),
                        ),
                      ),
                onChanged: (String? value) {
                  controller.otp.value = value ?? '';
                  controller.isFirstInputOTP.value = false;
                  controller.isInvalidOTP.value = false;
                },
              ),
            ),
            Expanded(
              child: Visibility(
                visible: (controller.otp.value.isEmpty &&
                        !controller.isFirstInputOTP.value) ||
                    controller.isInvalidOTP.value,
                child: Text(
                  controller.isInvalidOTP.value
                      ? 'Invalid OTP. Please try again!'
                      : 'OTP field is required!',
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
          ],
        ),
      );
}
