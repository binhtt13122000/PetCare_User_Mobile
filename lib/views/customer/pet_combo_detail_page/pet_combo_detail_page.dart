import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_combo_detail_page_controller.dart';
import 'package:petapp_mobile/views/customer/pet_combo_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/services/pet_combo_services.dart';
import 'package:petapp_mobile/views/customer/pet_combo_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetComboDetailPage extends GetView<PetComboDetailPageController> {
  const PetComboDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isWaitLoadingData.value = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller
        ..petComboModel = await PetComboServices.fetchPetComboById(
            petComboId: Get.parameters['petComboId']!)
        ..isWaitLoadingData.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(
        children: [
          const PetComboDetailTopWidget(),
          Obx(() => controller.isWaitLoadingData.value
              ? Expanded(
                  child: Container(
                      color: SUPPER_LIGHT_BLUE, child: LOADING_WIDGET()))
              : const PetComboDetailBodyWidget()),
        ],
      ),
    );
  }
}
