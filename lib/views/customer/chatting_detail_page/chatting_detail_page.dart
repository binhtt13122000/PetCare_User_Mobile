import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/chatting_page_controller.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/widgets/create_request_widget.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/widgets/top_widget.dart';

class ChattingDetailPage extends GetView<ChattingPageController> {
  const ChattingDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Stack(
        children: [
          Column(
            children: const [
              ChattingDetailTopWidget(),
              ChattingDetailBodyWidget(),
              ChattingDetailBottomWidget(),
            ],
          ),
          const CreateRequestWidget(),
        ],
      ),
    );
  }
}
