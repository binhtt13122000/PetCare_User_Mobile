import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_detail_page_controller.dart';
import 'package:petapp_mobile/models/service_ticket_model/service_ticket_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/ticket_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class TicketDetailBodyWidget extends GetView<TicketDetailPageController> {
  const TicketDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: SUPPER_LIGHT_BLUE,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ticketIdWidget(),
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
            const TicketDetailBottomWidget(),
          ],
        ),
      ),
    );
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

  Widget branchPerformServicesWidget() => Column(
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
                textCardWidget(
                    keyText: 'Branch address',
                    valueText: controller.ticketModel.branchModel!.address!),
                textCardWidget(
                    keyText: 'Branch phone number',
                    valueText: controller.ticketModel.branchModel!.phoneNumber),
              ],
            ),
          ),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
        ],
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
          Container(
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
          ),
        ],
      ),
    );
  }

  Widget ticketIdWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(
              'Ticket ID',
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
            CUSTOM_TEXT(
              (controller.ticketModel.id < 10 ? '#0' : '#') +
                  controller.ticketModel.id.toString(),
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
          ],
        ),
      );

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
