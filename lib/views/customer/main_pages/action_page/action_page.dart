import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/action_page_controller.dart';
import 'package:petapp_mobile/views/customer/main_pages/action_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/main_pages/action_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';

class ActionPage extends GetView<ActionPageController> {
  const ActionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: const [
                    ActionTopWidget(),
                    ActionPageBodyWidget(),
                  ],
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigatorBarWidget(route: ACTION_PAGE_ROUTE),
          )
        ],
      ),
    );
  }
}
