import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_post_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class UpdatePostBottomWidget extends GetView<UpdatePostPageController> {
  const UpdatePostBottomWidget({Key? key}) : super(key: key);

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
                onTap: () {
                  if (controller.title.value.isNotEmpty &&
                      controller.price.value > 0 &&
                      (controller.evidences.isNotEmpty ||
                          controller.evidencesPath.isNotEmpty)) {
                    controller.isShowConfirmPopup.value = true;
                  }
                },
                child: Obx(
                  () => Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: controller.title.value.isNotEmpty &&
                              controller.price.value > 0 &&
                              (controller.evidences.isNotEmpty ||
                                  controller.evidencesPath.isNotEmpty)
                          ? PRIMARY_COLOR
                          : PRIMARY_COLOR.withOpacity(0.3),
                    ),
                    child: CUSTOM_TEXT(
                      'Update Post',
                      textAlign: TextAlign.center,
                      color: WHITE_COLOR,
                      fontWeight: FontWeight.w700,
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
