import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/update_pet_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class UpdatePetBottomWidget extends GetView<UpdatePetPageController> {
  const UpdatePetBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withAlpha(50),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: InkWell(
                onTap: () async {
                  if (controller.petName.value.isNotEmpty &&
                      controller.dayOfBirthText.value.isNotEmpty) {
                    controller.isShowConfirmPopup.value = true;
                  }
                },
                child: Obx(
                  () => Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: controller.petName.value.isNotEmpty &&
                              controller.dayOfBirthText.value.isNotEmpty
                          ? PRIMARY_COLOR
                          : PRIMARY_COLOR.withOpacity(0.5),
                    ),
                    child: CUSTOM_TEXT(
                      'Update Pet',
                      textAlign: TextAlign.center,
                      color: WHITE_COLOR,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
