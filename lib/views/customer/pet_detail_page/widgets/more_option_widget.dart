import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetDetailMoreOptionWidget extends GetView<PetDetailPageController> {
  const PetDetailMoreOptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.isShowMoreOptionWidget.value,
          child: InkWell(
            onTap: () => controller.isShowMoreOptionWidget.value = false,
            child: Container(
              padding: const EdgeInsets.only(top: 30, right: 12),
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: DARK_GREY_COLOR.withOpacity(0.5),
                        offset: const Offset(3, 3),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget buttonWidget(
          {required content,
          bool isImportant = false,
          required Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: WHITE_COLOR,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isImportant
                  ? RED_COLOR
                  : DARK_GREY_TEXT_COLOR.withOpacity(0.5),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: CUSTOM_TEXT(
            content,
            textAlign: TextAlign.center,
            letterSpacing: 1,
            fontSize: 14,
            color: isImportant ? RED_COLOR : DARK_GREY_TEXT_COLOR,
          ),
        ),
      );
}
