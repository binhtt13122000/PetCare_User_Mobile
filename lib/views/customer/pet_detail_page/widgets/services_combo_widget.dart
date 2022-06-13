import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetDetailServicesComboWidget extends GetView<PetDetailPageController> {
  const PetDetailServicesComboWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        noExistPetCombo(),
      ],
    );
  }

  Widget noExistPetCombo() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 200),
        child: Column(
          children: [
            CUSTOM_TEXT(
                'Your pet doesn\'t have any services combo yet! Buy a services combo for your pet now.',
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.clip,
                letterSpacing: 2,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.7)),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () => Get.toNamed(BUY_SERVICES_COMBO_PAGE_ROUTE),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CUSTOM_TEXT(
                    'BUY A PET SERVICES COMBO',
                    color: WHITE_COLOR,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
