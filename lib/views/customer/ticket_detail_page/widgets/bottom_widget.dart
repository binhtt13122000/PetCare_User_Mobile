import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class TicketDetailBottomWidget extends GetView<TicketDetailPageController> {
  const TicketDetailBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withOpacity(0.1),
            ),
            cancelWidget(),
          ],
        ),
      );

  Widget cancelWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: InkWell(
          onTap: () => controller.isShowCancelPopup.value = true,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: RED_COLOR.withOpacity(0.05),
                border: Border.all(color: RED_COLOR.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: CUSTOM_TEXT(
                'CANCEL TICKET',
                textAlign: TextAlign.center,
                color: RED_COLOR,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      );
}
