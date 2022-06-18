import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_combo_detail_page_controller.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/services/pet_services/pet_combo_services.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/notification_popup_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/pet_services_list_status.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/pop_up_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/rating_popup_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/top_widget.dart';
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
        ..petComboStatus.value =
            controller.petComboModel.isCompleted ? 'Completed' : 'Not completed'
        ..isWaitLoadingData.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const PetComboDetailTopWidget(),
              Obx(() => controller.isWaitLoadingData.value
                  ? Expanded(
                      child: Container(
                          color: SUPPER_LIGHT_BLUE, child: LOADING_WIDGET()))
                  : const PetComboDetailBodyWidget()),
            ],
          ),
          const PetServicesListStatusBarWidget(),
          const PetComboDetailRatingPopupWidget(),
          const PetComboDetailPopupWidget(),
          const PetComboDetailNotificationPopupWidget(),
          Obx(
            () => Visibility(
              visible: controller.isWaitLoadingDataForeGround.value,
              child: Container(
                color: DARK_GREY_TRANSPARENT,
                child: LOADING_WIDGET(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
