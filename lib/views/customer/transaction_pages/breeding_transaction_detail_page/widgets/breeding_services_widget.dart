import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionDetailBreedingServicesWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailBreedingServicesWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        true ? noHaveDataWidget() : breedingServicesWidget(),
      ],
    );
  }

  Widget noHaveDataWidget() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(children: [
          CUSTOM_TEXT(
            'Your pet does not have any reproductive health services, buy one now!',
            textOverflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            fontSize: 14,
            padding: const EdgeInsets.symmetric(horizontal: 35),
          ),
          Row(),
        ]),
      );

  Widget breedingServicesWidget() => Column(
        children: [
          breedingServicesTimeLineWidget(),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 16,
            color: SUPPER_LIGHT_BLUE.withAlpha(30),
          ),
          branchWidget(),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 16,
            color: SUPPER_LIGHT_BLUE.withAlpha(30),
          ),
        ],
      );

  Widget branchWidget() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            CUSTOM_TEXT(
              'Branch perform services',
              padding: const EdgeInsets.only(bottom: 10),
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            textCardWidget(keyText: 'Name', valueText: 'HCM CS1'),
            textCardWidget(keyText: 'Phone number', valueText: '+84901905999'),
            textCardWidget(
                keyText: 'Address',
                valueText:
                    ' Lô E2a-7, Đường D1, Đ. D1, Long Thạnh Mỹ, Thành Phố Thủ Đức, Thành phố Hồ Chí Minh'),
          ],
        ),
      );

  Widget textCardWidget({required String keyText, required String valueText}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CUSTOM_TEXT(
              keyText,
              fontSize: 15,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
              padding: const EdgeInsets.only(right: 20),
            ),
            Expanded(
              child: CUSTOM_TEXT(valueText,
                  fontSize: 15,
                  textAlign: TextAlign.end,
                  textOverflow: TextOverflow.clip),
            ),
          ],
        ),
      );

  Widget breedingServicesTimeLineWidget() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            CUSTOM_TEXT(
              'Breeding services timeline',
              padding: const EdgeInsets.only(bottom: 20),
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            listTimelineItemWidget(),
          ],
        ),
      );

  Widget listTimelineItemWidget() {
    DateTime currentTime = DateTime.now();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        children: [
          Column(
            children: [
              timeLineItemWidget(currentTime: currentTime, isSuccess: true),
              timeLineItemWidget(currentTime: currentTime, isSuccess: true),
              timeLineItemWidget(currentTime: currentTime),
              timeLineItemWidget(currentTime: currentTime),
              timeLineItemWidget(currentTime: currentTime, isLastIndex: true),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 114),
            child: Column(
              children: [
                lineWidget(status: 'SUCCESS'),
                lineWidget(status: 'NEXT'),
                lineWidget(status: 'WAITING'),
                lineWidget(status: 'WAITING'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget lineWidget({required String status}) {
    double height = 85;
    Color color = LIGHT_GREY_COLOR.withOpacity(0.3);
    double margin = 24;
    switch (status) {
      case 'SUCCESS':
        height = 95;
        color = PRIMARY_COLOR;
        margin = 24;
        break;
      case 'NEXT':
        height = 98;
        color = PRIMARY_COLOR.withOpacity(0.5);
        margin = 24;
        break;
      case 'WAITING':
        height = 78;
        color = LIGHT_GREY_COLOR.withOpacity(0.15);
        margin = 20;
        break;
    }
    return status == 'NEXT'
        ? Padding(
            padding: EdgeInsets.only(top: margin),
            child: RotatedBox(
              quarterTurns: 1,
              child: SizedBox(
                height: 2,
                width: height,
                child: LinearProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation(PRIMARY_COLOR),
                  backgroundColor: LIGHT_GREY_COLOR.withOpacity(0.15),
                ),
              ),
            ),
          )
        : Container(
            width: 2,
            height: height,
            margin: EdgeInsets.only(top: margin),
            color: color,
          );
  }

  Widget timeLineItemWidget({
    required DateTime currentTime,
    bool isSuccess = false,
    bool isLastIndex = false,
  }) {
    int durationDays =
        (currentTime.difference(DateTime.now()).inHours / 24).ceil();

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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 25,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSuccess ? PRIMARY_COLOR : PRIMARY_COLOR.withOpacity(0.4),
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
                  fontSize: 14,
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
            Visibility(
              visible: !isSuccess,
              child: const SizedBox(
                height: 3,
                width: 2,
              ),
            ),
            isSuccess
                ? Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: const CircleAvatar(
                      backgroundColor: PRIMARY_COLOR,
                      minRadius: 12,
                      maxRadius: 12,
                      child: CircleAvatar(
                        backgroundColor: WHITE_COLOR,
                        minRadius: 10,
                        maxRadius: 10,
                        child: CircleAvatar(
                          backgroundColor: PRIMARY_COLOR,
                          minRadius: 8,
                          maxRadius: 8,
                          child: Icon(
                            Icons.done,
                            size: 14,
                            color: WHITE_COLOR,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: PRIMARY_COLOR.withOpacity(0.3),
                      minRadius: 10,
                      maxRadius: 10,
                      child: const Icon(
                        Icons.remove_circle_outline,
                        size: 18,
                        color: WHITE_COLOR,
                      ),
                    ),
                  ),
            Visibility(
              visible: !isLastIndex,
              child: SizedBox(
                height: isSuccess ? 95 : 75,
                width: 2,
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
                Row(
                  children: [
                    CUSTOM_TEXT('Pet breeding',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isSuccess
                            ? DARK_GREY_TEXT_COLOR.withOpacity(0.9)
                            : DARK_GREY_TEXT_COLOR.withOpacity(0.8)),
                  ],
                ),
                Row(
                  children: [
                    CUSTOM_TEXT('Status: ',
                        fontSize: 13,
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.85)),
                    CUSTOM_TEXT(isSuccess ? 'Successfully' : 'Waiting',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isSuccess ? GREEN_COLOR : YELLOW_COLOR),
                  ],
                ),
                const SizedBox(height: 3),
                CUSTOM_TEXT(
                  isSuccess
                      ? 'Perform on ' +
                          FORMAT_DATE_TIME(
                              dateTime: DateTime.now(), pattern: DATE_PATTERN_2)
                      : 'Estimated perform on ' +
                          FORMAT_DATE_TIME(
                              dateTime: DateTime.now(),
                              pattern: DATE_PATTERN_2),
                  fontSize: 13,
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
                  textOverflow: TextOverflow.clip,
                ),
                Visibility(
                  visible: isSuccess,
                  child: showDescriptionWidget(
                    description: 'ghghkh',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showDescriptionWidget({
    required String description,
  }) =>
      SizedBox(
        width: 200,
        child: Column(
          children: [
            Visibility(
              //visible: controller.showDescriptionIndexList.contains(index),
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: 'Description: ',
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
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
                  false ? 'Hide description' : 'View description',
                  style: GoogleFonts.quicksand(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: PRIMARY_COLOR,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  false
                      ? Icons.keyboard_double_arrow_up_outlined
                      : Icons.keyboard_double_arrow_down_outlined,
                  size: 14,
                  color: PRIMARY_COLOR,
                )
              ],
            ),
            Container(
              height: 1,
              width: 130,
              color: PRIMARY_COLOR,
              margin: const EdgeInsets.only(
                top: 2,
              ),
            ),
          ],
        ),
      );
  // Obx(
  //   () => InkWell(
  //     onTap: () => controller.showDescriptionIndexList.contains(index)
  //         ? controller.showDescriptionIndexList.remove(index)
  //         : controller.showDescriptionIndexList.add(index),
  //     child:
  //   ),
  // );
}
