import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/action_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ActionTopWidget extends GetView<ActionPageController> {
  const ActionTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          topTitleWidget(),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 0),
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 16,
            color: SUPPER_LIGHT_BLUE,
          ),
        ],
      );

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 15),
        child: CUSTOM_TEXT(
          'Actions Page',
          textAlign: TextAlign.center,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        ),
      );
}
