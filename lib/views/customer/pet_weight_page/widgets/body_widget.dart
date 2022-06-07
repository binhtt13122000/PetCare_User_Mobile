import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_weight_page_controller.dart';
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  charWidget(),
                  addDataWidget(),
                  wightItemWidget(
                    weight: 10.5,
                    dateTime: DateTime.now(),
                  ),
                  wightItemWidget(
                    weight: 10.5,
                    dateTime: DateTime.now(),
                  ),
                  wightItemWidget(
                    weight: 10.5,
                    dateTime: DateTime.now(),
                  ),
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
        width: 400,
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: controller.recordsTime.length.toDouble(),
            minY: 0,
            maxY: 6,
            titlesData: FlTitlesData(
              show: true,
              topTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (value) =>
                    value != 0 && value != 5 && value - value.toInt() == 0
                        ? FORMAT_DATE_TIME(
                            dateTime: DateTime.now(), pattern: DATE_PATTERN_2)
                        : '',
                getTextStyles: (_, value) =>
                    const TextStyle(fontSize: 10, color: DARK_GREY_TEXT_COLOR),
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTitles: (value) => '${value.toInt()}kg',
                getTextStyles: (_, value) =>
                    const TextStyle(fontSize: 12, color: DARK_GREY_TEXT_COLOR),
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
                spots: [
                  const FlSpot(1, 2),
                  const FlSpot(2, 5),
                  const FlSpot(3, 2),
                  const FlSpot(4, 2.5),
                ],
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
                  //  gradient: const LinearGradient(colors: [
                  //   Color.fromARGB(255, 123, 41, 255),
                  //   Color.fromARGB(255, 1, 226, 226),
                  // ]),
                  // belowBarData: BarAreaData(
                  //   show: true,
                  //   gradient: LinearGradient(colors: [
                  //     const Color.fromARGB(255, 123, 41, 255).withOpacity(0.1),
                  //     const Color.fromARGB(255, 1, 226, 226).withOpacity(0.1),
                  //   ]),
                ),
              ),
            ],
          ),
        ),
      );

  Widget addDataWidget() => Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: PRIMARY_LIGHT_COLOR.withOpacity(0.3),
                border: Border.all(color: PRIMARY_COLOR),
                borderRadius: BorderRadius.circular(5),
              ),
              child: CUSTOM_TEXT(
                'Add data',
                textAlign: TextAlign.center,
                color: PRIMARY_COLOR,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
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
