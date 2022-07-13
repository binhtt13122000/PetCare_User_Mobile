import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/ticket_detail_page_controller.dart';
import 'package:petapp_mobile/models/service_ticket_model/service_ticket_model.dart';
import 'package:petapp_mobile/services/transaction_services/ticket_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/ticket_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TicketDetailBodyWidget extends GetView<TicketDetailPageController> {
  const TicketDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketDetailPageController>(builder: (_) {
      controller.isLoadingData.value = true;
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        controller.ticketModel =
            await TicketServices.fetchTicketById(ticketId: controller.ticketId);
        controller.isLoadingData.value = false;
      });
      return Obx(
        () => controller.isLoadingData.value
            ? Expanded(child: LOADING_WIDGET())
            : Expanded(
                child: Container(
                  color: SUPPER_LIGHT_BLUE,
                  child: Column(
                    children: [
                      Expanded(
                        child: SmartRefresher(
                          controller: RefreshController(),
                          onRefresh: () => controller.update(),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ticketTimeWidget(),
                                servicesBookingWidget(),
                                estimateTimeWidget(),
                                Container(
                                  height: 1,
                                  color: LIGHT_GREY_COLOR.withAlpha(30),
                                ),
                                branchPerformServicesWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const TicketDetailBottomWidget(),
                    ],
                  ),
                ),
              ),
      );
    });
  }

  Widget ticketTimeWidget() => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(top: 20),
        color: WHITE_COLOR,
        child: Column(
          children: [
            textCardWidget(
                keyText: 'Booking date',
                valueText: FORMAT_DATE_TIME(
                    dateTime: controller.ticketModel.meetingDate,
                    pattern: DATE_PATTERN_2)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CUSTOM_TEXT('Booking time'),
                  Row(
                    children: [
                      CUSTOM_TEXT(
                        (controller.ticketModel.startTime ~/ 60 + 7)
                                .toString() +
                            ':' +
                            ((controller.ticketModel.startTime % 60) == 0
                                ? '00'
                                : '30') +
                            ((controller.ticketModel.startTime ~/ 60 + 7) <= 12
                                ? ' AM'
                                : ' PM'),
                      ),
                      CUSTOM_TEXT(
                        ' - ',
                      ),
                      CUSTOM_TEXT(
                        (controller.ticketModel.endTime ~/ 60 + 7).toString() +
                            ':' +
                            ((controller.ticketModel.endTime % 60) == 0
                                ? '00'
                                : '30') +
                            ((controller.ticketModel.endTime ~/ 60 + 7) <= 12
                                ? ' AM'
                                : ' PM'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
              margin: const EdgeInsets.only(top: 20),
            ),
          ],
        ),
      );

  Widget branchPerformServicesWidget() => Obx(
        () => Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: WHITE_COLOR,
              child: Column(
                children: [
                  CUSTOM_TEXT('Branch perform services'),
                  textCardWidget(
                      keyText: 'Branch name',
                      valueText: controller.ticketModel.branchModel!.name),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CUSTOM_TEXT(
                          'Branch address',
                          padding: const EdgeInsets.only(right: 15),
                        ),
                        Expanded(
                          child: CUSTOM_TEXT(
                            controller.ticketModel.branchModel!.address ??
                                'N/A',
                            textAlign: TextAlign.end,
                            textOverflow: controller.isShowBranchDetail.value
                                ? TextOverflow.clip
                                : TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.isShowBranchDetail.value,
                    child: textCardWidget(
                        keyText: 'Phone number',
                        valueText:
                            controller.ticketModel.branchModel!.phoneNumber),
                  ),
                  Visibility(
                    visible: controller.isShowBranchDetail.value,
                    child: textCardWidget(
                        keyText: 'Email',
                        valueText:
                            controller.ticketModel.branchModel!.email ?? 'N/A'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () => controller.isShowBranchDetail.value =
                            !controller.isShowBranchDetail.value,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CUSTOM_TEXT(
                                controller.isShowBranchDetail.value
                                    ? 'Hide branch details'
                                    : 'View branch details',
                                color: PRIMARY_COLOR,
                                fontSize: 13,
                                letterSpacing: 2,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                controller.isShowBranchDetail.value
                                    ? Icons.keyboard_double_arrow_up_outlined
                                    : Icons.keyboard_double_arrow_down_outlined,
                                size: 18,
                                color: PRIMARY_COLOR,
                              ),
                            ],
                          ),
                          Container(
                            height: 1,
                            width: 180,
                            color: PRIMARY_COLOR,
                            margin: const EdgeInsets.only(top: 2),
                          ),
                        ]),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
          ],
        ),
      );

  Widget textCardWidget({required String keyText, required String valueText}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(keyText),
            CUSTOM_TEXT(valueText),
          ],
        ),
      );

  Widget estimateTimeWidget() {
    String timeText = '';
    int hours =
        (controller.ticketModel.endTime - controller.ticketModel.startTime) ~/
            60;
    int minutes =
        (controller.ticketModel.endTime - controller.ticketModel.startTime) %
            60;

    if (hours > 0 && minutes > 0) {
      timeText = '$hours hours $minutes minutes';
    } else if (hours > 0) {
      timeText = '$hours hours';
    } else {
      timeText = '$minutes minutes';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      color: WHITE_COLOR,
      child: Row(
        children: [
          CUSTOM_TEXT('Estimate time to\nperform services',
              fontSize: 15, padding: const EdgeInsets.only(right: 10)),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget servicesBookingWidget() => Container(
        padding: const EdgeInsets.only(left: 12),
        color: WHITE_COLOR,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: CUSTOM_TEXT('Services booking'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: controller.ticketModel.serviceTicketModelList!
                    .asMap()
                    .entries
                    .map((e) =>
                        centerServicesItemWidget(serviceTicketModel: e.value))
                    .toList(),
              ),
            ),
          ],
        ),
      );

  Widget centerServicesItemWidget(
      {required ServiceTicketModel serviceTicketModel}) {
    String timeText = '';
    int hours = serviceTicketModel.centerServiceModel.estimatedTime ~/ 60;
    int minutes = serviceTicketModel.centerServiceModel.estimatedTime % 60;

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
                        serviceTicketModel.centerServiceModel.name +
                            (timeText.length > 10 ||
                                    serviceTicketModel
                                            .centerServiceModel.name.length >
                                        20
                                ? ''
                                : ' ($timeText)'),
                        color: WHITE_COLOR,
                        textAlign: TextAlign.center,
                      ),
                      Visibility(
                        visible: timeText.length > 10 ||
                            serviceTicketModel.centerServiceModel.name.length >
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
          ],
        ),
      ),
    );
  }
}
