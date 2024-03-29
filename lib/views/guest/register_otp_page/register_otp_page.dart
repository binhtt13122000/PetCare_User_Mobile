import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/register_page_controller.dart';
import 'package:petapp_mobile/views/guest/register_otp_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/guest/register_otp_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/guest/register_otp_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

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
                    color: DARK_GREY_TRANSPARENT,
                    child: LOADING_WIDGET(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
