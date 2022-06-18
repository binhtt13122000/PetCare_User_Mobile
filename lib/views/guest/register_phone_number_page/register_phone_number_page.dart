import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/register_page_controller.dart';
import 'package:petapp_mobile/views/guest/register_phone_number_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/guest/register_phone_number_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/guest/register_phone_number_page/widgets/top_widget.dart';

class RegisterPhoneNumberPage extends GetView<RegisterPageController> {
  const RegisterPhoneNumberPage({Key? key}) : super(key: key);

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
                RegisterPhoneNumberPageTopWidget(),
                RegisterPhoneNumberPageBodyWidget(),
                RegisterPhoneNumberPageBottomWidget(),
              ],
            ),
          ),
          Obx(
            () => controller.isLoadingPhoneCredential.value
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
