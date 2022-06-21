import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';

class BreedingTransactionDetailViewTypeTabWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailViewTypeTabWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(() => Visibility(
        visible: controller.isShowViewTypeTabWidget.value,
        child: Column(
          children: [
            Container(
              color: WHITE_COLOR,
              margin: const EdgeInsets.only(top: 115),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.viewTabList
                    .map((e) => viewTypeItemWidget(viewType: e))
                    .toList(),
              ),
            ),
          ],
        ),
      ));

  Widget viewTypeItemWidget({required String viewType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () => controller.selectedViewTab.value = viewType,
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedViewTab.value == viewType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : WHITE_COLOR,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.selectedViewTab.value == viewType
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
                          color: controller.selectedViewTab.value == viewType
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
                  color: controller.selectedViewTab.value == viewType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );
}
