import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/vaccine_list_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class VaccineListPageVaccinesWidget extends GetView<VaccineListPageController> {
  const VaccineListPageVaccinesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowVaccinesList.value
            ? InkWell(
                onTap: () => controller.isShowVaccinesList.value = false,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Container(
                      width: 300,
                      height: 300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      decoration: BoxDecoration(
                        color: WHITE_COLOR,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: controller.vaccinesMapKeys
                              .asMap()
                              .entries
                              .map((e) => vaccineItemWidget(
                                  vaccineName: e.value, index: e.key))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      );

  Widget vaccineItemWidget({required String vaccineName, required int index}) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
            InkWell(
              onTap: () => controller
                ..isShowVaccinesList.value = false
                ..selectedVaccine.value = vaccineName
                ..update(),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: index.isOdd
                          ? SUPPER_LIGHT_BLUE
                          : SUPPER_LIGHT_BLUE.withOpacity(0.3),
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      child: CUSTOM_TEXT(vaccineName,
                          textAlign: TextAlign.center,
                          padding: const EdgeInsets.symmetric(vertical: 7)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
          ],
        ),
      );
}
