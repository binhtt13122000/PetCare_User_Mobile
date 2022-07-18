import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/center_services_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/order_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/order_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/order_detail_page/widgets/more_options_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/order_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/cancel_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/review_popup_widget.dart';

class OrderDetailPage extends GetView<OrderDetailPageController> {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? transactionId = Get.parameters['transactionId'];
    if (transactionId != null) {
      controller.orderId = int.parse(transactionId);
    }
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: const [
                OrderDetailTopWidget(),
                OrderDetailBodyWidget(),
              ],
            ),
          ),
          const OrderDetailMoreOptionWidget(),
          Obx(
            () => controller.isShowCancelPopup.value
                ? CancelPopupWidget(
                    onTapBackground: () =>
                        controller.isShowCancelPopup.value = false,
                    title: 'Cancel Transaction',
                    content: 'Tell us the reason why you cancel?',
                    quickRateText: const [
                      'The seller did not come',
                      'I\'m busy',
                      'Sick pet',
                      'Pet is not correct',
                    ],
                    onChangeDescription: (String? text) {
                      controller.cancelDescription.value = text ?? '';
                    },
                    descriptionHintText: 'Type more about the reason why...',
                    isAllowSubmit: <bool>() =>
                        controller.cancelDescription.value.isNotEmpty ||
                        controller.quickCancelList.isNotEmpty,
                    onTapSubmit: () async {
                      controller.isWaitingUpdate.value = true;
                      String reasonText = GET_REVIEW_CONTENT(
                        description: controller.cancelDescription.value,
                        quickRateList: controller.quickCancelList,
                      );
                      await OrderServices.cancelOrder(
                        orderId: controller.orderId,
                        reasonCancel: reasonText,
                        cancelTime: DateTime.now(),
                      );

                      controller
                        ..isShowCancelPopup.value = false
                        ..onTapNotification = () {
                          controller
                            ..isShowNotificationPopup.value = false
                            ..update();
                        }
                        ..isSuccessNotification = true
                        ..notificationContent =
                            'Cancel transaction successfully.'
                        ..isWaitingUpdate.value = false
                        ..isShowNotificationPopup.value = true;
                    },
                    onTapQuickRateText: ({required String content}) {
                      controller.quickCancelList.contains(content)
                          ? controller.quickCancelList.remove(content)
                          : controller.quickCancelList.add(content);
                    },
                    isSelected: <bool>({required String content}) =>
                        controller.quickCancelList.contains(content),
                    checkEmptyDescription: <bool>() =>
                        controller.cancelDescription.value.isEmpty,
                    counterDescriptionText: <String>() =>
                        controller.cancelDescription.value.length.toString() +
                        '/200',
                    onDeleteDescription: () {
                      controller.cancelDescription.value = '';
                    },
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowReviewPopup.value
                ? ReviewPopupWidget(
                    onTapRatingBar: (double index) {
                      controller
                        ..selectedStar.value = index.toInt()
                        ..updateRatingText();
                    },
                    ratingText: <String>() => controller.ratingText.value,
                    onTapBackground: () =>
                        controller.isShowReviewPopup.value = false,
                    title: 'Rate Your Experience',
                    content: 'Tell us your services experience?',
                    quickRateText: const [
                      'The seller did not come',
                      'I\'m busy',
                      'Sick pet',
                      'Pet is not correct',
                    ],
                    onChangeDescription: (String? text) {
                      controller.reviewContent.value = text ?? '';
                    },
                    descriptionHintText: 'Type more about the experience...',
                    isAllowSubmit: <bool>() =>
                        controller.selectedStar.value > 0,
                    onTapSubmit: () async {
                      controller.isWaitingUpdate.value = true;
                      String reviewText = GET_REVIEW_CONTENT(
                        description: controller.reviewContent.value,
                        quickRateList: controller.quickFeedBackList,
                      );
                      await OrderServices.review(
                          transactionId: controller.orderModel.id,
                          star: controller.selectedStar.value,
                          review: reviewText);

                      controller
                        ..isWaitingUpdate.value = false
                        ..isShowReviewPopup.value = false
                        ..onTapNotification = () {
                          controller
                            ..isShowNotificationPopup.value = false
                            ..update();
                        }
                        ..isSuccessNotification = true
                        ..notificationContent =
                            'Review transaction successfully.'
                        ..isShowNotificationPopup.value = true;
                    },
                    onTapQuickRateText: ({required String content}) {
                      controller.quickFeedBackList.contains(content)
                          ? controller.quickFeedBackList.remove(content)
                          : controller.quickFeedBackList.add(content);
                    },
                    isSelected: <bool>({required String content}) =>
                        controller.quickFeedBackList.contains(content),
                    checkEmptyDescription: <bool>() =>
                        controller.reviewContent.value.isEmpty,
                    counterDescriptionText: <String>() =>
                        controller.reviewContent.value.length.toString() +
                        '/200',
                    onDeleteDescription: () {
                      controller.reviewContent.value = '';
                    },
                  )
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
              visible: controller.isWaitingUpdate.value,
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
