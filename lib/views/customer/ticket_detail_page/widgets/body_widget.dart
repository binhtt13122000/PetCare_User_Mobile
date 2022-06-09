import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_detail_page_controller.dart';
import 'package:petapp_mobile/models/service_ticket_model/service_ticket_model.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class TicketDetailBodyWidget extends GetView<TicketDetailPageController> {
  const TicketDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          addServicesWidget(),
        ],
      ),
    );
  }

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
            Column(
              children: controller.ticketModel.serviceTicketModelList!
                  .asMap()
                  .entries
                  .map((e) =>
                      centerServicesItemWidget(serviceTicketModel: e.value))
                  .toList(),
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
