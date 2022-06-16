import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/widgets/notification_popup_widget.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/widgets/pop_up_widget.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

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
          const PetManagementConfirmDeletePopupWidget(),
          const PetManagementNotificationPopupWidget(),
          Obx(() => Visibility(
                visible: controller.isWaitingDeletePet.value,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  child: LOADING_WIDGET(),
                ),
              )),
        ],
      ),
    );
  }
}
