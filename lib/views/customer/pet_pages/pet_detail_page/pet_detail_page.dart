import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/more_option_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/top_widget.dart';

class PetDetailPage extends GetView<PetDetailPageController> {
  const PetDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.parameters['petId'] != null) {
      controller.petId = int.parse(Get.parameters['petId']!);
    }

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: const [
              PetDetailTopWidget(),
              PetDetailBodyWidget(),
            ],
          ),
          const PetDetailMoreOptionWidget(),
        ],
      ),
    );
  }
}
