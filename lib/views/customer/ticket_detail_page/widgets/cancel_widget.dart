import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_detail_page_controller.dart';
import 'package:petapp_mobile/services/ticket_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class TicketDetailCancelWidget extends GetView<TicketDetailPageController> {
  const TicketDetailCancelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
          visible: controller.isShowCancelPopup.value,
          child: InkWell(
            onTap: () => controller.isShowCancelPopup.value = false,
            child: Container(
              color: DARK_GREY_TRANSPARENT,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 350,
                  width: 300,
                  child: Column(
                    children: [
                      CUSTOM_TEXT(
                        'Cancel Ticket Popup',
                        padding: const EdgeInsets.only(top: 20),
                        fontWeight: FontWeight.w700,
                      ),
                      reasonCancelWidget(),
                      quickReasonCancelWidget(),
                      reasonCancelTextFieldWidget(),
                      cancelTicketWidget(),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget quickReasonCancelWidget() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              spacing: 10,
              runSpacing: 10,
              children: controller.quickReasonCancelList
                  .asMap()
                  .entries
                  .map((e) => quickRateTextWidget(content: e.value))
                  .toList(),
            ),
          ),
        ],
      );

  Widget quickRateTextWidget({required content}) => Obx(
        () => InkWell(
          onTap: () => controller.selectReasonCancelList.contains(content)
              ? controller.selectReasonCancelList.remove(content)
              : controller.selectReasonCancelList.add(content),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: controller.selectReasonCancelList.contains(content)
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              border: Border.all(
                color: controller.selectReasonCancelList.contains(content)
                    ? PRIMARY_COLOR
                    : const Color.fromARGB(255, 85, 91, 110),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              content,
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                color: controller.selectReasonCancelList.contains(content)
                    ? WHITE_COLOR
                    : const Color.fromARGB(255, 85, 91, 110),
                fontWeight: FontWeight.w500,
                fontSize: 15,
                height: 1,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      );

  Widget cancelTicketWidget() => Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: InkWell(
            onTap: () async {
              if (controller.cancelTicketReason.value.isNotEmpty ||
                  controller.selectReasonCancelList.isNotEmpty) {
                String reasonCancel = '';

                if (controller.selectReasonCancelList.isEmpty) {
                  reasonCancel = controller.cancelTicketReason.value;
                } else {
                  int index = 0;
                  do {
                    reasonCancel +=
                        index == controller.selectReasonCancelList.length
                            ? '${controller.selectReasonCancelList[index]}, '
                            : '${controller.selectReasonCancelList[index]}. ';
                    index++;
                  } while (
                      index < controller.selectReasonCancelList.length - 1);

                  reasonCancel += ' ' + controller.cancelTicketReason.value;
                }

                controller.isWaitingUpdateTicket.value = true;
                await TicketServices.updateTicket(
                    ticketId: controller.ticketModel.id,
                    status: 'CANCELED',
                    reasonCancel: reasonCancel);
                controller
                  ..isWaitingUpdateTicket.value = false
                  ..isShowCancelPopup.value = false
                  ..isShowPopupWidget.value = true;
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: controller.cancelTicketReason.value.isNotEmpty ||
                          controller.selectReasonCancelList.isNotEmpty
                      ? RED_COLOR
                      : RED_COLOR.withOpacity(0.05),
                  border: Border.all(
                    color: controller.cancelTicketReason.value.isNotEmpty ||
                            controller.selectReasonCancelList.isNotEmpty
                        ? RED_COLOR.withOpacity(0.5)
                        : RED_COLOR.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: CUSTOM_TEXT(
                  'CANCEL TICKET',
                  textAlign: TextAlign.center,
                  color: controller.cancelTicketReason.value.isNotEmpty ||
                          controller.selectReasonCancelList.isNotEmpty
                      ? WHITE_COLOR
                      : RED_COLOR.withOpacity(0.3),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ),
      );

  Widget reasonCancelWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    CUSTOM_TEXT('Reason cancel ticket'),
                    CUSTOM_TEXT(
                      '*',
                      color: RED_COLOR,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                )),
          ],
        ),
      );

  Widget reasonCancelTextFieldWidget() => Container(
        height: 80,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 167, 181, 201),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          minLines: 3,
          maxLines: 3,
          onChanged: (String text) {
            controller.cancelTicketReason.value = text;
          },
          keyboardType: TextInputType.multiline,
          cursorColor: PRIMARY_COLOR,
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 113, 135, 168),
            fontSize: 15,
            letterSpacing: 1,
          ),
          decoration: InputDecoration.collapsed(
            hintText: 'Tell us more about the reason why you cancel ticket...',
            hintStyle: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 162, 176, 194),
              fontSize: 13,
              letterSpacing: 1,
            ),
          ),
        ),
      );
}
