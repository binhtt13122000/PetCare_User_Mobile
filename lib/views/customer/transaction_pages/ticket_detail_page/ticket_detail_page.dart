import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/action_page_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/ticket_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/ticket_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/ticket_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/ticket_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/cancel_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/confirm_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';

class TicketDetailPage extends GetView<TicketDetailPageController> {
  const TicketDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? ticketId = Get.parameters['ticketId'];
    if (ticketId != null) {
      controller.ticketId = int.parse(ticketId);
    }
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: const [
              TicketDetailTopWidget(),
              TicketDetailBodyWidget(),
            ],
          ),
          Obx(
            () => controller.isShowCancelPopup.value
                ? CancelPopupWidget(
                    onTapBackground: () =>
                        controller.isShowCancelPopup.value = false,
                    title: 'Cancel Ticket',
                    content: 'Tell us the reason why you cancel?',
                    quickRateText: controller.quickReasonCancelList,
                    onChangeDescription: (String? text) {
                      controller.cancelTicketReason.value = text ?? '';
                    },
                    descriptionHintText: 'Type more about the reason why...',
                    isAllowSubmit: <bool>() =>
                        controller.cancelTicketReason.value.isNotEmpty ||
                        controller.selectReasonCancelList.isNotEmpty,
                    onTapSubmit: () {
                      if (controller.cancelTicketReason.value.isNotEmpty ||
                          controller.selectReasonCancelList.isNotEmpty) {
                        controller.isShowConfirmPopup.value = true;
                      }
                    },
                    onTapQuickRateText: ({required String content}) {
                      controller.selectReasonCancelList.contains(content)
                          ? controller.selectReasonCancelList.remove(content)
                          : controller.selectReasonCancelList.add(content);
                    },
                    isSelected: <bool>({required String content}) =>
                        controller.selectReasonCancelList.contains(content),
                    checkEmptyDescription: <bool>() =>
                        controller.cancelTicketReason.value.isEmpty,
                    counterDescriptionText: <String>() =>
                        controller.cancelTicketReason.value.length.toString() +
                        '/200',
                    onDeleteDescription: () {
                      controller.cancelTicketReason.value = '';
                    },
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowConfirmPopup.value
                ? ConfirmPopupWidget(
                    onTapBackground: () {
                      controller.isShowConfirmPopup.value = false;
                    },
                    title: 'Cancel',
                    content:
                        'Are you sure to cancel ticket #${controller.ticketId}?',
                    onTapSubmit: () async {
                      controller
                        ..isShowConfirmPopup.value = false
                        ..isWaitingUpdateTicket.value = true;
                      String reasonText = GET_REVIEW_CONTENT(
                        description: controller.cancelTicketReason.value,
                        quickRateList: controller.selectReasonCancelList,
                      );
                      await TicketServices.updateTicket(
                          ticketId: controller.ticketModel.id,
                          status: 'CANCELED',
                          reasonCancel: reasonText);

                      controller
                        ..isWaitingUpdateTicket.value = false
                        ..isShowCancelPopup.value = false
                        ..onTapNotification = () {
                          Get
                            ..back()
                            ..find<ActionPageController>().update();
                        }
                        ..isSuccessNotification = true
                        ..notificationContent =
                            'Cancel ticket #${controller.ticketId} successfully.'
                        ..isShowNotificationPopup.value = true;
                    })
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowNotificationPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: controller.onTapNotification ?? () {},
                    content: controller.notificationContent,
                    isSuccessNotification: controller.isSuccessNotification,
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => Visibility(
              visible: controller.isWaitingUpdateTicket.value,
              child: Container(
                color: DARK_GREY_TRANSPARENT,
                child: LOADING_WIDGET(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
