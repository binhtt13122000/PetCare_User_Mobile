import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/controllers/chatting_list_page_controller.dart';
import 'package:petapp_mobile/views/customer/chatting_list_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/chatting_list_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';

class ChattingListPage extends GetView<ChattingListPageController> {
  const ChattingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Stack(
        children: [
          Column(
            children: const [
              ChattingListTopWidget(),
              ChattingListBodyWidget(),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigatorBarWidget(
                router: CHATTING_LIST_PAGE_ROUTE),
          )
        ],
      ),
    );
  }
}
