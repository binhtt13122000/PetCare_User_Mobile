import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SelectBranchWidget extends GetView<CreateTicketPageController> {
  const SelectBranchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                CUSTOM_TEXT('Branch perform services'),
                CUSTOM_TEXT(
                  '*',
                  color: RED_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
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
