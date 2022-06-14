import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetDetailHeathRecordsWidget extends GetView<PetDetailPageController> {
  const PetDetailHeathRecordsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      healthRecordItemWidget(title: 'Weight'),
      healthRecordItemWidget(title: 'Flushing worms'),
      healthRecordItemWidget(title: 'Vaccinations'),
      healthRecordItemWidget(title: 'Health status'),
      healthRecordItemWidget(title: 'Nutrition'),
      healthRecordItemWidget(title: 'Allergy'),
    ]);
  }

  Widget healthRecordItemWidget({
    required String title,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: InkWell(
          onTap: () =>
              Get.toNamed('$PET_WEIGHT_PAGE_ROUTE/${controller.petModel.id}'),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              boxShadow: [
                BoxShadow(
                  color: DARK_GREY_COLOR.withOpacity(0.05),
                  offset: const Offset(2, 2),
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CUSTOM_TEXT(
                      title,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: CUSTOM_TEXT(
                    'No data available at the moment',
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    border: Border.all(color: PRIMARY_COLOR),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CUSTOM_TEXT(
                    'Add data',
                    color: PRIMARY_COLOR,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
