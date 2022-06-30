import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/register_page_controller.dart';
import 'package:petapp_mobile/views/guest/register_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/guest/register_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/guest/register_page/widgets/pick_image_widget.dart';
import 'package:petapp_mobile/views/guest/register_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class RegisterUserInformationPage extends GetView<RegisterPageController> {
  const RegisterUserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              RegisterPageTopWidget(),
              RegisterPageBodyWidget(),
              RegisterPageBottomWidget(),
            ],
          ),
          const PickImageWidget(),
          Obx(
            () => controller.isLoadingRegister.value
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
