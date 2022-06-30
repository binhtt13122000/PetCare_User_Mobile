import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/add_pet_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreatePetLoadingWidget extends GetView<CreatePetPageController> {
  const CreatePetLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isWaitingCreatePet.value,
        child: Container(
          color: DARK_GREY_TRANSPARENT,
          child: LOADING_WIDGET(),
        ),
      ),
    );
  }
}
