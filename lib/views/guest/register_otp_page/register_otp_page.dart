import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/register_page_controller.dart';
import 'package:petapp_mobile/views/guest/register_otp_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/guest/register_otp_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/guest/register_otp_page/widgets/top_widget.dart';

class RegisterOTPPage extends GetView<RegisterPageController> {
  const RegisterOTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                RegisterOTPPageTopWidget(),
                RegisterOTPPageBodyWidget(),
                RegisterOTPPageBottomWidget(),
              ],
            ),
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
    );
  }
}
