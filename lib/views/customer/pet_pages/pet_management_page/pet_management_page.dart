import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_management_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_management_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_management_page/widgets/bottom_widget.dart';

import 'package:petapp_mobile/views/customer/pet_pages/pet_management_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/confirm_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';

class PetManagementPage extends GetView<PetManagementPageController> {
  const PetManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: const [
              PetsManagementTopWidget(),
              PetsManagementBodyWidget(),
              PetsManagementBottomWidget(),
            ],
          ),
          Obx(
            () => controller.isShowConfirmPopup.value
                ? ConfirmPopupWidget(
                    onTapBackground: () {
                      controller.isShowConfirmPopup.value = false;
                    },
                    title: 'Delete Pet',
                    content:
                        'Are you sure to delete pet ${controller.selectedPetModel.name}?',
                    onTapSubmit: () async {
                      controller
                        ..isShowConfirmPopup.value = false
                        ..isWaitingDeletePet.value = true;
                      await PetService.deletePetByPetId(
                          petId: controller.selectedPetModel.id);

                      controller
                        ..notificationTitle = 'Delete pet '
                        ..isWaitingDeletePet.value = false
                        ..isShowNotificationPopup.value = true;
                    })
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowNotificationPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: () => controller
                      ..update()
                      ..isShowNotificationPopup.value = false,
                    content:
                        'Delete pet ${controller.selectedPetModel.name} successfully.')
                : const SizedBox.shrink(),
          ),
          Obx(
            () => Visibility(
              visible: controller.isWaitingDeletePet.value,
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
