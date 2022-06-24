import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_breeding_services_combo_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyBreedingServicesComboSelectBranchWidget
    extends GetView<BuyBreedingServicesComboPageController> {
  const BuyBreedingServicesComboSelectBranchWidget({Key? key})
      : super(key: key);

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
            ],
          ),
          Obx(
            () => Row(
              children: [
                CUSTOM_TEXT('Branch address',
                    padding: const EdgeInsets.only(right: 10)),
                CUSTOM_TEXT(''),
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
