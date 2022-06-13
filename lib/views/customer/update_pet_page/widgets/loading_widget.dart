import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/update_pet_page_controller.dart';

class UpdatePetLoadingWidget extends GetView<UpdatePetPageController> {
  const UpdatePetLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isWaitingUpdatePet.value,
        child: Container(
          color: const Color.fromARGB(106, 198, 188, 201),
          alignment: Alignment.center,
          child: const SpinKitSpinningLines(
            color: PRIMARY_COLOR,
            size: 150,
          ),
        ),
      ),
    );
  }
}
