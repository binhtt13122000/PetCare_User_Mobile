import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/generate_qr_code_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_generate_qr_code_services.dart';
import 'package:petapp_mobile/views/customer/generate_qr_code/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/generate_qr_code/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetGenerateQrCodePage extends GetView<GenerateQrCodeController> {
  const PetGenerateQrCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['petId'] != null) {
      controller.petId = int.parse(Get.parameters['petId']!);
    }
    return Scaffold(
      backgroundColor: Colors.pink.shade500,
      body: Stack(
        children: [
          Column(children: [
            const PetGenerateQrCodeTopWidget(),
            GetBuilder<GenerateQrCodeController>(builder: (_) {
              controller.isWaitingLoadingData.value = true;
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
                controller.petDeepLink.value =
                    await PetGenerateQrCodeService.fetchDeepLinkFromPetId(
                        petId: controller.petId.toString());
                controller.isWaitingLoadingData.value = false;
                controller.startTimer();
              });
              return Obx(() => controller.isWaitingLoadingData.value
                  ? Expanded(child: LOADING_WIDGET())
                  : const PetGenerateQrCodeBodyWidget());
            })
          ]),
        ],
      ),
    );
  }
}
