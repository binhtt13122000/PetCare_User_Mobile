import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/booking_breeding_service_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BookingBreedingServicesSelectBranchWidget
    extends GetView<BookingBreedingServicesPageController> {
  const BookingBreedingServicesSelectBranchWidget({Key? key}) : super(key: key);

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
                  CUSTOM_TEXT(
                    'Register branch',
                    fontSize: 15,
                  ),
                  CUSTOM_TEXT('*',
                      color: RED_COLOR,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      padding: const EdgeInsets.only(right: 20)),
                ],
              ),
              Obx(
                () => Expanded(
                  child: DropdownButton<int>(
                    alignment: Alignment.center,
                    borderRadius: BorderRadius.circular(10),
                    value: controller.selectBranchIndex.value,
                    items: controller.branchModelList
                        .asMap()
                        .entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(
                              e.value.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: DARK_GREY_TEXT_COLOR,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (int? value) {
                      controller.selectBranchIndex.value = value!;
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Obx(
            () => Row(
              children: [
                CUSTOM_TEXT(
                  'Branch address',
                  padding: const EdgeInsets.only(right: 20),
                  fontSize: 15,
                ),
                Expanded(
                  child: CUSTOM_TEXT(
                    controller
                            .branchModelList[controller.selectBranchIndex.value]
                            .address ??
                        'N/A',
                    fontSize: 15,
                    textAlign: TextAlign.end,
                  ),
                ),
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
