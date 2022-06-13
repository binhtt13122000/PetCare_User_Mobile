import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyPetServicesComboSelectBranchWidget
    extends GetView<BuyServicesComboPageController> {
  const BuyPetServicesComboSelectBranchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: WHITE_COLOR,
      child: Row(
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
              value: controller.selectBranchId.value,
              items: controller.branchModelList
                  .map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(
                        e.name,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 78, 98, 124),
                          fontSize: 16,
                        ),
                      )))
                  .toList(),
              onChanged: (int? value) {
                controller
                  ..selectBranchId.value = value!
                  ..update();
              },
            ),
          ),
        ],
      ),
    );
  }
}
