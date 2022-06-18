import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/remove_ticks_history_page_controller.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class RemoveTicksHistoryBodyWidget
    extends GetView<RemoveTicksHistoryPageController> {
  const RemoveTicksHistoryBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          color: SUPPER_LIGHT_BLUE,
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: controller.dewormingList.isNotEmpty
                ? Column(
                    children: [
                      suggestNextTimeWidget(),
                      Container(
                        height: 1,
                        color: LIGHT_GREY_COLOR.withAlpha(30),
                      ),
                      vaccinationsTimeLineWidget(),
                    ],
                  )
                : Center(
                    child: CUSTOM_TEXT(
                        'Sorry, your pet has no remove ticks data!',
                        padding: const EdgeInsets.only(top: 300)),
                  ),
          ),
        ),
      );

  Widget suggestNextTimeWidget() => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: WHITE_COLOR,
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: BLUE_COLOR,
              maxRadius: 5,
            ),
            const SizedBox(
              width: 15,
            ),
            CUSTOM_TEXT(
              'Suggest the next\nremove ticks time',
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                CUSTOM_TEXT(
                  FORMAT_DATE_TIME(
                      dateTime: controller.dewormingList[0].dateOfInjection
                                  .add(const Duration(days: 90))
                                  .difference(DateTime.now())
                                  .inDays <
                              0
                          ? DateTime.now()
                          : controller.dewormingList[0].dateOfInjection
                              .add(const Duration(days: 90)),
                      pattern: DATE_PATTERN_2),
                  color: BLUE_COLOR,
                  fontWeight: FontWeight.w700,
                ),
                CUSTOM_TEXT('(Should be remove\nticks every 3 months)',
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 12,
                    textAlign: TextAlign.center),
              ],
            ),
          ],
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
          CUSTOM_TEXT('Remove Ticks Timeline',
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              padding: const EdgeInsets.only(bottom: 20)),
          Column(
            children: controller.dewormingList
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
                CUSTOM_TEXT(
                  FORMAT_DATE_TIME(
                      dateTime: petHealthRecordModel.dateOfInjection,
                      pattern: DATE_PATTERN_2),
                  fontSize: 15,
                  color: DARK_GREY_COLOR.withOpacity(0.8),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
                CUSTOM_TEXT(
                  'Remove tick in branch ' +
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
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'Description: ',
                        style: GoogleFonts.quicksand(
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                          fontSize: 13,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: description,
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.showDescriptionIndexList.contains(index)
                          ? 'Hide description'
                          : 'View description',
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: backgroundColor,
                        letterSpacing: 2,
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
                  margin: const EdgeInsets.only(top: 2, left: 15, right: 15),
                ),
              ],
            ),
          ),
        ),
      );
}
