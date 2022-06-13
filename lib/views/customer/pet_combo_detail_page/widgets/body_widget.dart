import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_combo_detail_page_controller.dart';
import 'package:petapp_mobile/models/pet_combo_detail_model/pet_combo_detail_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetComboDetailBodyWidget extends GetView<PetComboDetailPageController> {
  const PetComboDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          color: SUPPER_LIGHT_BLUE,
          child: SingleChildScrollView(
            child: Column(
              children: [
                petComboIdWidget(),
                petServicesComboGeneralInformationWidget(),
                Container(
                  height: 1,
                  color: DARK_GREY_COLOR.withAlpha(30),
                ),
                petServicesComboItemListWidget(),
              ],
            ),
          ),
        ),
      );

  Widget petServicesComboItemListWidget() => Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 20),
        color: WHITE_COLOR,
        child: Column(
          children: [
            CUSTOM_TEXT(
              'Pet services list',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 2,
            ),
            Column(
              children: controller.petComboModel.petComboDetailModelList!
                  .asMap()
                  .entries
                  .map((e) => petServicesComboItemWidget(
                      petComboDetailModel: e.value, index: e.key + 1))
                  .toList(),
            ),
          ],
        ),
      );

  Widget petServicesComboItemWidget(
      {required PetComboDetailModel petComboDetailModel, required int index}) {
    String timeText = '';
    int hours = petComboDetailModel.centerServiceModel.estimatedTime ~/ 60;
    int minutes = petComboDetailModel.centerServiceModel.estimatedTime % 60;

    if (hours > 0 && minutes > 0) {
      timeText = '$hours hours : $minutes minutes';
    } else if (hours > 0) {
      timeText = '$hours hours';
    } else {
      timeText = '$minutes minutes';
    }
    return Container(
      color: index.isEven ? WHITE_COLOR : LIGHT_GREY_COLOR.withOpacity(0.02),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
            margin: const EdgeInsets.only(bottom: 5),
          ),
          textCardWidget(
              keyText: '#0${index.toString()}',
              valueText: petComboDetailModel.centerServiceModel.name),
          textCardWidget(
              keyText: 'Estimated execution date',
              valueText: FORMAT_DATE_TIME(
                  dateTime: petComboDetailModel.workingTime,
                  pattern: DATE_PATTERN_2)),
          textCardWidget(
              keyText: 'Estimated execution time', valueText: timeText),
          textCardWidget(
              keyText: 'Execution date',
              valueText: petComboDetailModel.realTime != null
                  ? FORMAT_DATE_TIME(
                      dateTime: petComboDetailModel.realTime!,
                      pattern: DATE_PATTERN_2)
                  : 'N/A'),
          textCardWidget(
            keyText: 'Description',
            valueText:
                petComboDetailModel.centerServiceModel.description ?? 'N/A',
          ),
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
            margin: const EdgeInsets.only(top: 5),
          ),
        ],
      ),
    );
  }

  Widget petComboIdWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(
              'Pet services combo ID',
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
            CUSTOM_TEXT(
              (controller.petComboModel.id < 10 ? '#0' : '#') +
                  controller.petComboModel.id.toString(),
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
          ],
        ),
      );

  Widget petServicesComboGeneralInformationWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: WHITE_COLOR,
        child: Column(
          children: [
            textCardWidget(
                keyText: 'Name',
                valueText: controller.petComboModel.servicesComboModel.name),
            textCardWidget(
                keyText: 'Type',
                valueText: controller.petComboModel.servicesComboModel.type),
            textCardWidget(
                keyText: 'Is completed',
                valueText: controller.petComboModel.isCompleted ? 'YES' : 'NO'),
            textCardWidget(
              keyText: 'Register date',
              valueText: FORMAT_DATE_TIME(
                  dateTime: controller.petComboModel.registerTime,
                  pattern: DATE_PATTERN_2),
            ),
          ],
        ),
      );

  Widget textCardWidget({required String keyText, required String valueText}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(keyText),
            Expanded(
              child: CUSTOM_TEXT(
                valueText,
                textAlign: TextAlign.right,
                textOverflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      );
}
