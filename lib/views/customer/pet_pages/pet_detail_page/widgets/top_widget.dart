import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_management_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetDetailTopWidget extends GetView<PetDetailPageController> {
  const PetDetailTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          topWidget(),
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
          ),
          petIdWidget(),
        ],
      );

  Widget petIdWidget() => Container(
        color: SUPPER_LIGHT_BLUE,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(
              'Pet ID',
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
            ),
            CUSTOM_TEXT(
              (controller.petId < 10 ? '#0' : '#') +
                  controller.petId.toString(),
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
          ],
        ),
      );

  Widget topWidget() => Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //*back button
            InkWell(
              onTap: () => Get
                ..back()
                ..put(PetManagementPageController()).update(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: DARK_GREY_COLOR.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Color.fromARGB(255, 61, 78, 100),
                  size: 18,
                ),
              ),
            ),
            //*app logo
            Expanded(
              child: Obx(
                () => FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CUSTOM_TEXT(controller.topTitle.value,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      textAlign: TextAlign.center,
                      fontSize: 18,
                      padding: const EdgeInsets.symmetric(horizontal: 20)),
                ),
              ),
            ),

            //*more options
            Obx(
              () => !controller.isLoadingData.value
                  ? InkWell(
                      onTap: () =>
                          controller.isShowMoreOptionWidget.value = true,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: WHITE_COLOR,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: DARK_GREY_COLOR.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          ICON_PATH + ELLIPSIS_SVG,
                          height: 15,
                          color: const Color.fromARGB(255, 61, 78, 100),
                        ),
                      ),
                    )
                  : const SizedBox(
                      width: 35,
                    ),
            ),
          ],
        ),
      );
}
