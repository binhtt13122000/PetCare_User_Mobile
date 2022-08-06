import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_management_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/more_option_widget.dart';
import 'package:petapp_mobile/views/widgets/confirm_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';

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
          const PetDetailBodyWidget(),
          const PetDetailMoreOptionWidget(),
          Obx(
            () => controller.isShowConfirmPopup.value
                ? ConfirmPopupWidget(
                    onTapBackground: () {
                      controller.isShowConfirmPopup.value = false;
                    },
                    title: 'Delete Pet',
                    content:
                        'Are you sure to delete pet ${controller.petModel.name}?',
                    onTapSubmit: () async {
                      controller
                        ..isShowConfirmPopup.value = false
                        ..isWaitingDeletePet.value = true;
                      await PetService.deletePetByPetId(
                          jwt: controller.accountModel.jwtToken,
                          petId: controller.petModel.id);

                      controller
                        ..isWaitingDeletePet.value = false
                        ..isShowNotificationPopup.value = true;
                    })
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowNotificationPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: () => Get
                      ..back()
                      ..find<PetManagementPageController>().update(),
                    content:
                        'Delete pet ${controller.petModel.name} successfully.')
                : const SizedBox.shrink(),
          ),
          Obx(() => controller.isWaitingDeletePet.value
              ? Container(
                  color: DARK_GREY_TRANSPARENT,
                  child: LOADING_WIDGET(),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
