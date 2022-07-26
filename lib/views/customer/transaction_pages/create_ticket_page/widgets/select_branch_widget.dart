import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/create_ticket_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SelectBranchWidget extends GetView<CreateTicketPageController> {
  const SelectBranchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: WHITE_COLOR,
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
              value: controller.selectBranchIndex.value,
              items: controller.branchModelList
                  .asMap()
                  .entries
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.key,
                      child: Text(
                        e.value.name,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 78, 98, 124),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (int? value) {
                controller
                  ..selectBranchIndex.value = value!
                  ..update();
              },
            ),
          ),
        ],
      ),
    );
  }
}
