import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyPetServicesComboSelectBranchWidget
    extends GetView<BuyServicesComboPageController> {
  const BuyPetServicesComboSelectBranchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: WHITE_COLOR,
      child: Column(
        children: [
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CUSTOM_TEXT('Register branch'),
                  CUSTOM_TEXT('*',
                      color: RED_COLOR,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      padding: const EdgeInsets.only(right: 20)),
                ],
              ),
              Obx(
                () => DropdownButton<int>(
                  value: controller.selectBranchIndex.value,
                  items: controller.branchModelList
                      .asMap()
                      .entries
                      .map((e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(
                            e.value.name,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 78, 98, 124),
                              fontSize: 16,
                            ),
                          )))
                      .toList(),
                  onChanged: (int? value) {
                    controller
                      ..selectBranchIndex.value = value!
                      ..branchAddress.value = controller
                          .branchModelList[controller.selectBranchIndex.value]
                          .address!;
                  },
                ),
              ),
            ],
          ),
          Obx(
            () => Row(
              children: [
                CUSTOM_TEXT('Branch address',
                    padding: const EdgeInsets.only(right: 10)),
                CUSTOM_TEXT(controller.branchAddress.value),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
