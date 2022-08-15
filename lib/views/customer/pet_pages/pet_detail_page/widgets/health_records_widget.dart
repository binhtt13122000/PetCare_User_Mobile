import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';
import 'package:petapp_mobile/services/pet_services/pet_health_records_services.dart';
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
                    jwt: controller.accountModel.jwtToken,
                    petId: controller.petId.toString(),
                    type: 'VACCINE')
            ..sortVaccinesList()
            ..dewormingList =
                await PetHealthRecordsServices.fetchPetHealthRecordList(
                    jwt: controller.accountModel.jwtToken,
                    petId: controller.petId.toString(),
                    type: 'HELMINTHIC')
            ..sortDewormingList()
            ..removeTicksList =
                await PetHealthRecordsServices.fetchPetHealthRecordList(
                    jwt: controller.accountModel.jwtToken,
                    petId: controller.petId.toString(),
                    type: 'TICKS')
            ..sortRemoveTicksList()
            ..isLoadingHealthRecord.value = false;
        });
        return Obx(
          () => controller.isLoadingHealthRecord.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: LOADING_WIDGET(),
                )
              : Column(children: [
                  vaccineItemWidget(),
                  dewormingItemWidget(),
                  removeTicksItemWidget(),
                  // healthRecordItemWidget(title: 'Weight'),
                ]),
        );
      });

  Widget removeTicksItemWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: InkWell(
          onTap: () {
            if (controller.removeTicksList.isNotEmpty) {
              Get.toNamed('$REMOVE_TICKS_PAGE_ROUTE/${controller.petModel.id}');
            }
          },
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
                      'Remove Ticks',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                    Visibility(
                      visible: controller.removeTicksList.isNotEmpty,
                      child: Text(
                        'View detail >',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: PRIMARY_COLOR.withOpacity(
                              0.8,
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
                controller.removeTicksList.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: CUSTOM_TEXT(
                          'Your pet has no remove\nticks data at the moment!',
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                          textAlign: TextAlign.center,
                          fontSize: 14,
                        ),
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: GREEN_COLOR,
                                        maxRadius: 5,
                                      ),
                                      CUSTOM_TEXT(
                                        'Last remove ticks date',
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                CUSTOM_TEXT(
                                  FORMAT_DATE_TIME(
                                      dateTime: controller
                                          .removeTicksList[0].dateOfInjection,
                                      pattern: DATE_PATTERN_2),
                                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: BLUE_COLOR,
                                        maxRadius: 5,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CUSTOM_TEXT(
                                            'Suggest next time',
                                            fontSize: 15,
                                          ),
                                          CUSTOM_TEXT(
                                            '(Should be remove\nticks every 3 months)',
                                            color: DARK_GREY_TEXT_COLOR
                                                .withOpacity(0.8),
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                CUSTOM_TEXT(
                                  FORMAT_DATE_TIME(
                                      dateTime: controller.removeTicksList[0]
                                                  .dateOfInjection
                                                  .add(const Duration(days: 90))
                                                  .difference(DateTime.now())
                                                  .inDays <
                                              0
                                          ? DateTime.now()
                                          : controller.removeTicksList[0]
                                              .dateOfInjection
                                              .add(const Duration(days: 90)),
                                      pattern: DATE_PATTERN_2),
                                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      );

  Widget dewormingItemWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: InkWell(
          onTap: () {
            if (controller.dewormingList.isNotEmpty) {
              Get.toNamed(
                  '$DEWORMING_HISTORY_PAGE_ROUTE/${controller.petModel.id}');
            }
          },
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
                      'Deworming',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                    Visibility(
                      visible: controller.dewormingList.isNotEmpty,
                      child: Text(
                        'View detail >',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: PRIMARY_COLOR.withOpacity(
                              0.8,
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
                controller.dewormingList.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: CUSTOM_TEXT(
                          'Your pet has no deworming\ndata at the moment!',
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                          textAlign: TextAlign.center,
                          fontSize: 14,
                        ),
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: GREEN_COLOR,
                                        maxRadius: 5,
                                      ),
                                      CUSTOM_TEXT(
                                        'Last deworming date',
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                CUSTOM_TEXT(
                                  FORMAT_DATE_TIME(
                                      dateTime: controller
                                          .dewormingList[0].dateOfInjection,
                                      pattern: DATE_PATTERN_2),
                                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: BLUE_COLOR,
                                        maxRadius: 5,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CUSTOM_TEXT(
                                            'Suggest next time',
                                            fontSize: 15,
                                          ),
                                          CUSTOM_TEXT(
                                            '(Should be dewormed\nevery 3 months)',
                                            color: DARK_GREY_TEXT_COLOR
                                                .withOpacity(0.8),
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                CUSTOM_TEXT(
                                  FORMAT_DATE_TIME(
                                      dateTime: controller.dewormingList[0]
                                                  .dateOfInjection
                                                  .add(const Duration(days: 90))
                                                  .difference(DateTime.now())
                                                  .inDays <
                                              0
                                          ? DateTime.now()
                                          : controller
                                              .dewormingList[0].dateOfInjection
                                              .add(const Duration(days: 90)),
                                      pattern: DATE_PATTERN_2),
                                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      );

  Widget vaccineItemWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: InkWell(
          onTap: () {
            if (controller.vaccinesList.isNotEmpty) {
              Get.toNamed('$VACCINE_LIST_PAGE_ROUTE/${controller.petModel.id}');
            }
          },
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
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                    Visibility(
                      visible: controller.vaccinesList.isNotEmpty,
                      child: Text(
                        'View detail >',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: PRIMARY_COLOR.withOpacity(
                              0.8,
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
                          'Your pet has no vaccinations\ndata at the moment!',
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                          textAlign: TextAlign.center,
                          fontSize: 14,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(top: 10),
                        height: controller.vaccinesList.length >= 3
                            ? 90
                            : controller.vaccinesList.length * 50,
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
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: GREEN_COLOR,
                    maxRadius: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CUSTOM_TEXT(
                        vaccine.vaccineModel!.name,
                        padding: const EdgeInsets.only(left: 15),
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                      ),
                      CUSTOM_TEXT(
                        '(${vaccine.vaccineType!})',
                        padding: const EdgeInsets.only(left: 15),
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CUSTOM_TEXT(
              FORMAT_DATE_TIME(
                  dateTime: vaccine.dateOfInjection, pattern: DATE_PATTERN_2),
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
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
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: CUSTOM_TEXT(
                    'No data available at the moment!',
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
