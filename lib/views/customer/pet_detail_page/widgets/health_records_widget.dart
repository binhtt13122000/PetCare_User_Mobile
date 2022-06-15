import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';
import 'package:petapp_mobile/services/pet_health_records_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetDetailHeathRecordsWidget extends GetView<PetDetailPageController> {
  const PetDetailHeathRecordsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      GetBuilder<PetDetailPageController>(builder: (_) {
        controller.isLoadingHealthRecord.value = true;
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller
            ..vaccinesList =
                await PetHealthRecordsServices.fetchPetHealthRecordList(
                    petId: controller.petModel.id.toString(), type: 'VACCINE')
            ..isLoadingHealthRecord.value = false;
        });
        return Obx(
          () => controller.isLoadingHealthRecord.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: LOADING_WIDGET(),
                )
              : Column(children: [
                  healthRecordItemWidget(title: 'Weight'),
                  vaccineItemWidget(),
                  healthRecordItemWidget(title: 'Flushing worms'),
                  healthRecordItemWidget(title: 'Health status'),
                  healthRecordItemWidget(title: 'Nutrition'),
                  healthRecordItemWidget(title: 'Allergy'),
                ]),
        );
      });

  Widget vaccineItemWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: InkWell(
          onTap: () =>
              Get.toNamed('$VACCINE_LIST_PAGE_ROUTE/${controller.petModel.id}'),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CUSTOM_TEXT(
                      'Vaccinations',
                    ),
                    Visibility(
                      child: Text(
                        'View detail >',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: PRIMARY_COLOR.withOpacity(
                              0.7,
                            ),
                          ),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                controller.vaccinesList.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: CUSTOM_TEXT(
                          'No data available at the moment',
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(top: 10),
                        height: 100,
                        child: SingleChildScrollView(
                          child: Column(
                            children: controller.vaccinesList
                                .map((e) => vaccineDetailItemWidget(vaccine: e))
                                .toList(),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );

  Widget vaccineDetailItemWidget({required PetHealthRecordModel vaccine}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CUSTOM_TEXT(vaccine.vaccineModel!.name,
                    padding: const EdgeInsets.only(left: 30)),
                CUSTOM_TEXT(
                  ' (${vaccine.vaccineType!})',
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                  fontSize: 15,
                ),
              ],
            ),
            CUSTOM_TEXT(
              FORMAT_DATE_TIME(
                  dateTime: vaccine.dateOfInjection, pattern: DATE_PATTERN_2),
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
              fontSize: 15,
            ),
          ],
        ),
      );

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
