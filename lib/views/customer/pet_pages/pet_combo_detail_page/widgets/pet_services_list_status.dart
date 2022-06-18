import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_combo_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetServicesListStatusBarWidget
    extends GetView<PetComboDetailPageController> {
  const PetServicesListStatusBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.isShowServicesStatusBarWidget.value,
          child: Column(
            children: [
              const SizedBox(
                height: 105,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: WHITE_COLOR,
                child: Column(
                  children: [
                    CUSTOM_TEXT(
                      'Pet services list',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      letterSpacing: 2,
                      padding: const EdgeInsets.only(bottom: 10),
                    ),
                    servicesStatusWidget(),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      );

  Widget servicesStatusWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.servicesStatus
            .asMap()
            .entries
            .map((e) => servicesStatusItemWidget(viewType: e.value))
            .toList(),
      );

  Widget servicesStatusItemWidget({required String viewType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () => controller
              ..selectServicesStatus.value = viewType
              ..isShowServicesStatusBarWidget.value = false
              ..update(),
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectServicesStatus.value == viewType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.selectServicesStatus.value == viewType
                          ? const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                maxRadius: 3,
                                backgroundColor: PRIMARY_COLOR,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        viewType,
                        style: GoogleFonts.quicksand(
                          color:
                              controller.selectServicesStatus.value == viewType
                                  ? PRIMARY_COLOR
                                  : const Color.fromARGB(255, 116, 122, 143),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  color: controller.selectServicesStatus.value == viewType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );
}
