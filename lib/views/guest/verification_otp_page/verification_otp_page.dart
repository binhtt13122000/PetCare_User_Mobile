import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';

class VerificationOTPPage extends GetView<SignInPageController> {
  const VerificationOTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      print('co tin nhan: ');

      if (remoteNotification != null && androidNotification != null) {
        print('co tin nhan: ' + remoteNotification.body!);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      print('co tin nhan: ');
      if (remoteNotification != null && androidNotification != null) {
        print('co tin nhan: ' + remoteNotification.body!);
      }
    });
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verification OTP',
                              style: GoogleFonts.itim(
                                textStyle:
                                    const TextStyle(color: PRIMARY_COLOR),
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                height: 1,
                              ),
                            ),
                            Text(
                              'Enter the OTP you received from: ' +
                                  controller.selectedAreaCode.value +
                                  controller.phoneNumber.value,
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
                      ), //!phone number text field
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  cursorColor: PRIMARY_COLOR,
                                  initialValue: controller.otp.value,
                                  style: GoogleFonts.itim(
                                    fontSize: 25,
                                    color: PRIMARY_COLOR,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLength: 6,
                                  decoration: controller.otp.value.isEmpty &&
                                          !controller.isFirstInputOTP
                                      ? const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: -15),
                                          errorText:
                                              'The field otp is required',
                                          suffixIcon: Icon(
                                            Icons.error,
                                            color: Color.fromARGB(
                                                255, 241, 99, 88),
                                            size: 20,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 241, 99, 88),
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
                                    controller.otp.value = value!;
                                    controller.isFirstInputOTP = false;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => Stack(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                        value: controller.countDownTime.value /
                                            controller.maxTime,
                                        color: PRIMARY_LIGHT_COLOR,
                                        backgroundColor: PRIMARY_COLOR,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      child: Text(
                                        controller.countDownTime.value
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.itim(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        child: MaterialButton(
                          color: PRIMARY_LIGHT_COLOR,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign In',
                                style: GoogleFonts.quicksand(
                                  color: PRIMARY_COLOR,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            controller.isLoadingOTP.value = true;
                            PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: controller.verificationId,
                                    smsCode: controller.otp.value);
                            controller.signInWithPhoneAuthCredential(
                                phoneAuthCredential);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Obx(
              () => controller.isLoadingOTP.value
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
