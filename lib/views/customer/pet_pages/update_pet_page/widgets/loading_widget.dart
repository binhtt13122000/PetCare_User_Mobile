import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/update_pet_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class UpdatePetLoadingWidget extends GetView<UpdatePetPageController> {
  const UpdatePetLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isWaitingUpdatePet.value,
        child: Container(
          color: DARK_GREY_TRANSPARENT,
          alignment: Alignment.center,
          child: LOADING_WIDGET(),
        ),
      ),
    );
  }
}
