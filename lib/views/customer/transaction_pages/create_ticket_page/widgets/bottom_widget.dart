import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/create_ticket_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreateTicketBottomWidget extends GetView<CreateTicketPageController> {
  const CreateTicketBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: LIGHT_GREY_COLOR.withAlpha(30),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          color: WHITE_COLOR,
          child: InkWell(
            onTap: () async {
              if (controller.selectedTicketTimeIndex.value != -1 &&
                  controller.selectCenterServicesIndexList.isNotEmpty) {
                controller.isShowConfirmPopup.value = true;
              }
            },
            child: Obx(
              () => Container(
                height: 40,
                decoration: BoxDecoration(
                  color: controller.selectedTicketTimeIndex.value != -1 &&
                          controller.selectCenterServicesIndexList.isNotEmpty
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CUSTOM_TEXT(
                      'Send Ticket',
                      color: WHITE_COLOR,
                      textAlign: TextAlign.center,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      ICON_PATH + SEND_SVG,
                      height: 20,
                      color: WHITE_COLOR,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
