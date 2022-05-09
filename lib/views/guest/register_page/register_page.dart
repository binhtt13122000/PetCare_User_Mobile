import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/register_page_controller.dart';
import 'package:petapp_mobile/views/guest/register_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/guest/register_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/guest/register_page/widgets/pick_image_widget.dart';
import 'package:petapp_mobile/views/guest/register_page/widgets/top_widget.dart';

class RegisterPage extends GetView<RegisterPageController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
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
        ],
      ),
    );
  }
}
