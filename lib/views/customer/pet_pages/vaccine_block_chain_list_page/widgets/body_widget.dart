import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:flutter_html/flutter_html.dart';

class VaccineBlockChainListPageBodyWidget
    extends GetView<PetBlockChainPageController> {
  const VaccineBlockChainListPageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          color: SUPPER_LIGHT_BLUE,
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                vaccineName(),
                Row(),
                Container(
                  height: 1,
                  color: LIGHT_GREY_COLOR.withAlpha(30),
                ),
                controller.vaccinesMapKeys.length > 1
                    ? vaccinationsTimeLineWidget()
                    : CUSTOM_TEXT('Sorry, your pet has no vaccination data!',
                        padding: const EdgeInsets.only(top: 200)),
              ],
            ),
          ),
        ),
      );

  Widget vaccinationsTimeLineWidget() {
    DateTime currentTime = DateTime.now();
    return Container(
      color: WHITE_COLOR,
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          CUSTOM_TEXT(
            'Injected Vaccines Timeline',
            letterSpacing: 1,
            padding: const EdgeInsets.only(bottom: 20),
            fontWeight: FontWeight.w700,
          ),
          Column(
            children: controller.vaccinesMap[controller.selectedVaccine.value]!
                .asMap()
                .entries
                .map((e) => vaccinationsTimeLineItemWidget(
                      petHealthRecordModel: e.value,
                      currentTime: currentTime,
                      index: e.key + 1,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget vaccinationsTimeLineItemWidget(
      {required PetHealthRecordModel petHealthRecordModel,
      required DateTime currentTime,
      required int index}) {
    int durationDays =
        (currentTime.difference(petHealthRecordModel.dateOfInjection).inHours /
                24)
            .ceil();

    String durationText = '';
    String durationUnit = '';

    if (durationDays >= 365) {
      durationText = (durationDays / 365).ceil().toString();
      durationUnit = ' years ago';
    } else if (durationDays >= 30) {
      durationText = (durationDays / 30).ceil().toString();
      durationUnit = ' months ago';
    } else if (durationDays != 0) {
      durationText = durationDays.toString();
      durationUnit = ' days ago';
    } else {
      durationText = 'Today';
      durationUnit = '';
    }

    // Color backgroundColor = const Color.fromRGBO(163, 55, 244, 1);
    Color backgroundColor = Colors.primaries[index].withOpacity(0.8);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 30,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                // Expanded(
                //   child: CUSTOM_TEXT(
                //     durationText,
                //     textAlign: TextAlign.right,
                //     fontWeight: FontWeight.w700,
                //     color: WHITE_COLOR,
                //     fontSize: 15,
                //   ),
                // ),
                // Container(
                //   width: 80,
                //   padding: const EdgeInsets.only(right: 10),
                //   child: FittedBox(
                //     fit: BoxFit.scaleDown,
                //     child: CUSTOM_TEXT(
                //       durationUnit,
                //       fontSize: 14,
                //       textAlign: TextAlign.start,
                //       color: WHITE_COLOR,
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),

                CUSTOM_TEXT(
                  durationText,
                  textAlign: TextAlign.center,
                  color: WHITE_COLOR,
                  fontWeight: FontWeight.w700,
                ),
                CUSTOM_TEXT(
                  durationUnit,
                  textAlign: TextAlign.center,
                  color: WHITE_COLOR,
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 30,
              child: CircleAvatar(
                backgroundColor: backgroundColor,
                minRadius: 10,
                maxRadius: 10,
              ),
            ),
            Obx(
              () => Container(
                height: controller.showDescriptionIndexList.contains(index)
                    ? 110
                    : 85,
                width: 2,
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: LIGHT_GREY_COLOR.withOpacity(0.3),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.selectedVaccine.value != 'All vaccines'
                    ? Row(
                        children: [
                          CUSTOM_TEXT(
                            'Type: ',
                            fontSize: 15,
                          ),
                          CUSTOM_TEXT(
                            petHealthRecordModel.vaccineType ?? '',
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          CUSTOM_TEXT(
                            petHealthRecordModel.vaccineModel!.name,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          CUSTOM_TEXT(
                            ' (' +
                                (petHealthRecordModel.vaccineType ?? '') +
                                ')',
                          ),
                        ],
                      ),
                const SizedBox(height: 5),
                CUSTOM_TEXT(
                  'Injected at ' +
                      FORMAT_DATE_TIME(
                          dateTime: petHealthRecordModel.dateOfInjection,
                          pattern: DATE_PATTERN_2),
                  fontSize: 15,
                  color: DARK_GREY_COLOR.withOpacity(0.7),
                ),
                CUSTOM_TEXT(
                  'Injected in branch ' +
                      petHealthRecordModel.branchModel!.name,
                  textOverflow: TextOverflow.clip,
                  fontSize: 15,
                  color: DARK_GREY_COLOR.withOpacity(0.7),
                ),
                showDescriptionWidget(
                  backgroundColor: backgroundColor,
                  index: index,
                  description: petHealthRecordModel.description ?? 'N/A',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showDescriptionWidget(
          {required Color backgroundColor,
          required int index,
          required String description}) =>
      Obx(
        () => InkWell(
          onTap: () => controller.showDescriptionIndexList.contains(index)
              ? controller.showDescriptionIndexList.remove(index)
              : controller.showDescriptionIndexList.add(index),
          child: SizedBox(
            width: 200,
            child: Column(
              children: [
                Visibility(
                  visible: controller.showDescriptionIndexList.contains(index),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Html(
                      data: description,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.showDescriptionIndexList.contains(index)
                          ? 'Hide vaccine description'
                          : 'View vaccine description',
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: backgroundColor,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      controller.showDescriptionIndexList.contains(index)
                          ? Icons.keyboard_double_arrow_up_outlined
                          : Icons.keyboard_double_arrow_down_outlined,
                      size: 18,
                      color: backgroundColor,
                    )
                  ],
                ),
                Container(
                  height: 1,
                  color: backgroundColor,
                  margin: const EdgeInsets.only(
                    top: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget vaccineName() => Container(
        decoration: const BoxDecoration(color: WHITE_COLOR),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Obx(
          () => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 150, child: CUSTOM_TEXT('Select vaccine')),
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.isShowVaccinesList.value = true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: WHITE_COLOR,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: PRIMARY_COLOR),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CUSTOM_TEXT(
                                controller.selectedVaccine.value,
                                color: PRIMARY_COLOR,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: PRIMARY_COLOR,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              vaccineInformationWidget(),
            ],
          ),
        ),
      );

  Widget vaccineInformationWidget() =>
      Obx(() => controller.selectedVaccine.value != 'All vaccines'
          ? Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: CUSTOM_TEXT(
                        'Vaccine origin',
                      ),
                    ),
                    Expanded(
                      child: CUSTOM_TEXT(
                        controller
                            .vaccinesMap[controller.selectedVaccine.value]![0]
                            .vaccineModel!
                            .origin,
                        textOverflow: TextOverflow.clip,
                        textAlign: TextAlign.right,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: CUSTOM_TEXT(
                        'Description',
                      ),
                    ),
                    Expanded(
                      child: CUSTOM_TEXT(
                        controller
                                .vaccinesMap[controller.selectedVaccine.value]![
                                    0]
                                .vaccineModel!
                                .description ??
                            '',
                        textOverflow: TextOverflow.clip,
                        textAlign: TextAlign.right,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                )
              ],
            )
          : const SizedBox.shrink());
}
