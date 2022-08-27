import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetBlockChainDetailHeathRecordsWidget
    extends GetView<PetBlockChainPageController> {
  const PetBlockChainDetailHeathRecordsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(children: [
        vaccineItemWidget(),
        dewormingItemWidget(),
        removeTicksItemWidget(),
        //healthRecordItemWidget(title: 'Weight'),
      ]);

  Widget removeTicksItemWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: InkWell(
          onTap: () {
            if (controller.petHealthRecordMap['TICKS'] != null) {
              Get.toNamed(REMOVE_TICKS_BLOCKCHAIN_PAGE_ROUTE);
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
                      visible: controller.petHealthRecordMap['TICKS'] != null,
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
                controller.petHealthRecordMap['TICKS'] == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: CUSTOM_TEXT(
                          'Your pet has no remove\nticks data at the moment',
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                          textAlign: TextAlign.center,
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
                                      CUSTOM_TEXT('Last remove ticks date',
                                          padding:
                                              const EdgeInsets.only(left: 15)),
                                    ],
                                  ),
                                ),
                                CUSTOM_TEXT(
                                  FORMAT_DATE_TIME(
                                      dateTime: controller
                                          .petHealthRecordMap['TICKS']![0]
                                          .dateOfInjection,
                                      pattern: DATE_PATTERN_2),
                                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
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
            if (controller.petHealthRecordMap['HELMINTHIC'] != null) {
              Get.toNamed(DEWORMING_BLOCKCHAIN_HISTORY_PAGE_ROUTE);
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
                      visible:
                          controller.petHealthRecordMap['HELMINTHIC'] != null,
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
                controller.petHealthRecordMap['HELMINTHIC'] == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: CUSTOM_TEXT(
                          'Your pet has no deworming\ndata at the moment',
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                          textAlign: TextAlign.center,
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
                                      CUSTOM_TEXT('Last deworming date',
                                          padding:
                                              const EdgeInsets.only(left: 15)),
                                    ],
                                  ),
                                ),
                                CUSTOM_TEXT(
                                  FORMAT_DATE_TIME(
                                      dateTime: controller
                                          .petHealthRecordMap['HELMINTHIC']![0]
                                          .dateOfInjection,
                                      pattern: DATE_PATTERN_2),
                                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
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
            if (controller.petHealthRecordMap['VACCINE'] != null) {
              Get.toNamed(VACCINE_LIST_BLOCKCHAIN_PAGE_ROUTE);
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
                      visible: controller.petHealthRecordMap['VACCINE'] != null,
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
                controller.petHealthRecordMap['VACCINE'] == null
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
                        height: controller
                                    .petHealthRecordMap['VACCINE']!.length >=
                                3
                            ? 90
                            : controller.petHealthRecordMap['VACCINE']!.length *
                                50,
                        child: SingleChildScrollView(
                          child: Column(
                            children: controller.petHealthRecordMap['VACCINE']!
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
                    'Your pet has no weight\ndata at the moment',
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
