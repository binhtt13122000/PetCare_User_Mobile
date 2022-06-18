import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/views/guest/sign_in_verification_otp_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/guest/sign_in_verification_otp_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/guest/sign_in_verification_otp_page/widgets/top_widget.dart';

class SignInVerificationOTPPage extends GetView<SignInPageController> {
  const SignInVerificationOTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SignInVerificationOTPPageTopWidget(),
                SignInVerificationOTPBodyWidget(),
                SignInVerificationBottomWidget(),
              ],
            ),
          ),
          Obx(
            () => controller.isLoadingOTP.value
                ? Container(
                    color: DARK_GREY_TRANSPARENT,
                    child: const SpinKitSpinningLines(
                      color: PRIMARY_COLOR,
                      size: 150,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
