import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_page_controller.dart';
import 'package:petapp_mobile/services/ticket_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/widgets/select_branch_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreateTicketBodyWidget extends GetView<CreateTicketPageController> {
  const CreateTicketBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  addServicesWidget(),
                  estimateTimeWidget(),
                  Container(
                    height: 1,
                    margin: const EdgeInsets.only(top: 20),
                    color: LIGHT_GREY_COLOR.withAlpha(30),
                  ),
                  Container(
                    height: 8,
                    color: SUPPER_LIGHT_BLUE,
                  ),
                  const SelectBranchWidget(),
                  selectUseServicesDateWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 12),
                    child: Row(
                      children: [
                        CUSTOM_TEXT('Time booking services'),
                        CUSTOM_TEXT(
                          '*',
                          color: RED_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<CreateTicketPageController>(builder: (_) {
                    if (controller.totalEstimateTime.value > 0) {
                      controller.isLoadingTicketList.value = true;

                      WidgetsBinding.instance!.addPostFrameCallback((_) async {
                        controller
                          ..ticketModelList =
                              await TicketServices.fetchTicketListByBranch(
                            branchId: controller.selectBranchId.value,
                            bookingTime: controller.bookingServicesDate,
                          )
                          ..setTicketTimeModelList()
                          ..isLoadingTicketList.value = false;
                      });
                    } else {
                      controller.selectedTicketTimeIndex.value = -1;
                    }
                    return Obx(() => controller.isLoadingTicketList.value
                        ? LOADING_WIDGET(size: 60)
                        : timeItemWidget());
                  }),
                ],
              ),
            ),
          ),
          const CreateTicketBottomWidget(),
        ],
      ),
    );
  }

  Widget estimateTimeWidget() => Padding(
        padding: const EdgeInsets.only(left: 12, top: 20),
        child: Row(
          children: [
            CUSTOM_TEXT('Estimate time to\nperform services',
                fontSize: 15, padding: const EdgeInsets.only(right: 10)),
            Obx(() {
              String timeText = '';
              int hours = controller.totalEstimateTime.value ~/ 60;
              int minutes = controller.totalEstimateTime.value % 60;

              if (hours > 0 && minutes > 0) {
                timeText = '$hours hours $minutes minutes';
              } else if (hours > 0) {
                timeText = '$hours hours';
              } else {
                timeText = '$minutes minutes';
              }

              return Container(
                padding: const EdgeInsets.all(8.0),
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: LIGHT_GREY_COLOR.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CUSTOM_TEXT(
                  timeText,
                ),
              );
            }),
          ],
        ),
      );

  Widget addServicesWidget() => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  CUSTOM_TEXT('Services booking'),
                  CUSTOM_TEXT(
                    '*',
                    color: RED_COLOR,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            Obx(
              () => Column(
                children: controller.selectCenterServicesIndexList
                    .asMap()
                    .entries
                    .map((e) => centerServicesItemWidget(index: e.value))
                    .toList(),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.selectCenterServicesIndexList.length < 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 42, top: 10),
                  child: InkWell(
                    onTap: () => controller.isShowAddServices.value = true,
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
                              'Add Services',
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
                ),
              ),
            ),
          ],
        ),
      );

  Widget centerServicesItemWidget({required int index}) {
    String timeText = '';
    int hours = controller.centerServicesModelList[index].estimatedTime ~/ 60;
    int minutes = controller.centerServicesModelList[index].estimatedTime % 60;

    if (hours > 0 && minutes > 0) {
      timeText = '$hours hours $minutes minutes';
    } else if (hours > 0) {
      timeText = '$hours hours';
    } else {
      timeText = '$minutes minutes';
    }
    return Padding(
      padding: const EdgeInsets.only(right: 42, left: 30, top: 5, bottom: 5),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CUSTOM_TEXT(
                        controller.centerServicesModelList[index].name +
                            (timeText.length > 10 ||
                                    controller.centerServicesModelList[index]
                                            .name.length >
                                        20
                                ? ''
                                : ' ($timeText)'),
                        color: WHITE_COLOR,
                        textAlign: TextAlign.center,
                      ),
                      Visibility(
                        visible: timeText.length > 10 ||
                            controller.centerServicesModelList[index].name
                                    .length >
                                20,
                        child: CUSTOM_TEXT(
                          '($timeText)',
                          color: WHITE_COLOR,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => controller
                ..selectCenterServicesIndexList.remove(index)
                ..totalEstimateTime -=
                    controller.centerServicesModelList[index].estimatedTime
                ..update(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                color: WHITE_COLOR.withOpacity(0.7),
                height: 40,
                child: SvgPicture.asset(
                  ICON_PATH + CLOSE_SVG,
                  color: RED_COLOR,
                  height: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeItemWidget() => Obx(() {
        return controller.selectedTicketTimeIndex.value != -1 &&
                controller.totalEstimateTime.value != 0
            ? Padding(
                padding: const EdgeInsets.only(top: 10, left: 12),
                child: InkWell(
                  onTap: () => controller.isShowPickTimeWidget.value = true,
                  child: Container(
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: LIGHT_GREY_COLOR.withOpacity(0.3),
                        ),
                        color: WHITE_COLOR),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CUSTOM_TEXT(
                            (controller
                                                .ticketTimeModelList[controller
                                                    .selectedTicketTimeIndex
                                                    .value]
                                                .startTime ~/
                                            60 +
                                        7)
                                    .toString() +
                                ':' +
                                ((controller
                                                .ticketTimeModelList[controller
                                                    .selectedTicketTimeIndex
                                                    .value]
                                                .startTime %
                                            60) ==
                                        0
                                    ? '00'
                                    : '30') +
                                ((controller
                                                    .ticketTimeModelList[controller
                                                        .selectedTicketTimeIndex
                                                        .value]
                                                    .startTime ~/
                                                60 +
                                            7) <=
                                        12
                                    ? ' AM'
                                    : ' PM'),
                            fontSize: 17,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        CUSTOM_TEXT(
                          ' - ',
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          fontSize: 17,
                        ),
                        Expanded(
                          child: CUSTOM_TEXT(
                            (controller
                                                .ticketTimeModelList[controller
                                                    .selectedTicketTimeIndex
                                                    .value]
                                                .endTime ~/
                                            60 +
                                        7)
                                    .toString() +
                                ':' +
                                ((controller
                                                .ticketTimeModelList[controller
                                                    .selectedTicketTimeIndex
                                                    .value]
                                                .endTime %
                                            60) ==
                                        0
                                    ? '00'
                                    : '30') +
                                ((controller
                                                    .ticketTimeModelList[controller
                                                        .selectedTicketTimeIndex
                                                        .value]
                                                    .endTime ~/
                                                60 +
                                            7) <=
                                        12
                                    ? ' AM'
                                    : ' PM'),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            fontSize: 17,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: DARK_GREY_TEXT_COLOR,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : CUSTOM_TEXT(
                controller.totalEstimateTime.value == 0
                    ? 'Select booking services\nto chose booking time!'
                    : 'There are currently no available time!\nPlease choose another date.',
                color: controller.totalEstimateTime.value == 0
                    ? DARK_GREY_TEXT_COLOR.withOpacity(0.7)
                    : PINK_COLOR,
                textAlign: TextAlign.center,
                padding: const EdgeInsets.only(top: 10),
              );
      });

  Widget selectUseServicesDateWidget() => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  CUSTOM_TEXT('Date booking services'),
                  CUSTOM_TEXT(
                    '*',
                    color: RED_COLOR,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                dateItemWidget(index: 0),
                dateItemWidget(
                  dateTime: DateTime.now().add(const Duration(days: 2)),
                  index: 1,
                ),
                dateItemWidget(
                  dateTime: DateTime.now().add(const Duration(days: 3)),
                  index: 2,
                ),
              ],
            ),
          ],
        ),
      );

  Widget dateItemWidget({DateTime? dateTime, required int index}) => Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: InkWell(
            onTap: () => controller
              ..selectedDateIndex.value = index
              ..bookingServicesDate =
                  DateTime.now().add(Duration(days: 1 + index))
              ..update(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: controller.selectedDateIndex.value == index
                      ? PRIMARY_COLOR
                      : LIGHT_GREY_COLOR.withOpacity(0.3),
                ),
                color: controller.selectedDateIndex.value == index
                    ? PRIMARY_COLOR
                    : WHITE_COLOR,
              ),
              child: CUSTOM_TEXT(
                dateTime != null
                    ? FORMAT_DATE_TIME(
                        dateTime: dateTime, pattern: DATE_PATTERN_2)
                    : 'Tomorrow',
                color: controller.selectedDateIndex.value == index
                    ? WHITE_COLOR
                    : DARK_GREY_TEXT_COLOR,
              ),
            ),
          ),
        ),
      );
}
