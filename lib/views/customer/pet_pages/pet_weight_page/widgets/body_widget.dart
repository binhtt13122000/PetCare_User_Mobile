import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_weight_page_controller.dart';
import 'package:petapp_mobile/models/weight_record_model/weight_record_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class PetWeightBodyWidget extends GetView<PetWeightPageController> {
  const PetWeightBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: SUPPER_LIGHT_BLUE,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CUSTOM_TEXT(
                  'Pet ID',
                  fontSize: 13,
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                ),
                CUSTOM_TEXT(
                  '#0' + controller.petModel.id.toString(),
                  fontSize: 13,
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: charWidget()),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  addDataWidget(),
                  Column(
                      children: controller.recordsTime
                          .asMap()
                          .entries
                          .map(
                            (e) => wightItemWidget(
                              weight: e.value.weight,
                              dateTime: e.value.recordTime,
                            ),
                          )
                          .toList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget charWidget() => Container(
        margin: const EdgeInsets.only(top: 20, right: 30, left: 10),
        height: 300,
        width: 350,
        child: Obx(
          () => LineChart(
            LineChartData(
              minX: 0.5,
              maxX: controller.recordsTime.length.toDouble() + 0.5,
              minY: controller.minWeight.value != 0
                  ? controller.minWeight.value - 1
                  : controller.minWeight.value,
              maxY: controller.maxWeight.value + 1,
              titlesData: FlTitlesData(
                show: true,
                topTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) => value != 0 &&
                          value !=
                              controller.recordsTime.length.toDouble() + 1 &&
                          value - value.toInt() == 0
                      ? FORMAT_DATE_TIME(
                          dateTime: controller
                              .recordsTime[value.toInt() - 1].recordTime,
                          pattern: DATE_PATTERN_3)
                      : '',
                  getTextStyles: (_, value) => const TextStyle(
                    fontSize: 10,
                    color: DARK_GREY_TEXT_COLOR,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) => '${value.toInt()}kg',
                  getTextStyles: (_, value) => const TextStyle(
                    fontSize: 9,
                    color: DARK_GREY_TEXT_COLOR,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                rightTitles: SideTitles(showTitles: false),
              ),
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(strokeWidth: 1);
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(strokeWidth: 1);
                },
                drawHorizontalLine: true,
                drawVerticalLine: false,
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: controller.recordsTime
                      .asMap()
                      .entries
                      .map((e) => FlSpot(e.key.toDouble() + 1, e.value.weight))
                      .toList(),
                  isCurved: true,
                  barWidth: 3,
                  colors: [
                    const Color.fromARGB(255, 123, 41, 255),
                    const Color.fromARGB(255, 1, 226, 226),
                  ],
                  belowBarData: BarAreaData(
                    show: true,
                    colors: [
                      const Color.fromARGB(255, 123, 41, 255).withOpacity(0.1),
                      const Color.fromARGB(255, 1, 226, 226).withOpacity(0.1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget addDataWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: InkWell(
          onTap: () => controller
            ..recordsTime.add(
              WeightRecordModel(
                recordTime: DateTime.now(),
                weight: controller.maxWeight.value + 1,
              ),
            )
            ..maxWeight.value += 1,
          child: DottedBorder(
            color: PRIMARY_COLOR.withOpacity(0.7),
            strokeWidth: 1,
            radius: const Radius.circular(5),
            borderType: BorderType.RRect,
            dashPattern: const [5, 5],
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: PRIMARY_COLOR.withOpacity(0.05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CUSTOM_TEXT(
                    'Add data',
                    color: PRIMARY_COLOR,
                    letterSpacing: 1,
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    ICON_PATH + ADD_SVG,
                    height: 18,
                    color: PRIMARY_COLOR,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget wightItemWidget(
          {required double weight, required DateTime dateTime}) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withAlpha(30),
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CUSTOM_TEXT('$weight kilogram'),
                CUSTOM_TEXT(
                  FORMAT_DATE_TIME(
                      dateTime: dateTime, pattern: DATE_TIME_PATTERN),
                ),
              ],
            ),
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withAlpha(30),
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),
          ],
        ),
      );
}
