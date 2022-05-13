import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/views/customer/chatting_landing_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/chatting_landing_page/widgets/top_widget.dart';

class ChattingLandingPage extends GetView {
  const ChattingLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Column(
        children: const [
          ChattingLandingTopWidget(),
          ChattingLandingBodyWidget(),
        ],
      ),
    );
  }
}
