import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/confirm_pop_up_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/more_options_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/review_popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/view_detail_popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/view_tab_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/web_view.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/cancel_popup_widget.dart';

class BreedingTransactionDetailPage
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['breedingTransactionId'] != null) {
      controller.breedingTransactionId =
          int.parse(Get.parameters['breedingTransactionId']!);
    }
    controller.isWaitingLoadingInitData.value = true;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller
        ..breedingTransactionModel =
            await BreedingTransactionService.fetchBreedingTransactionById(
                breedingTransactionId: controller.breedingTransactionId)
        ..sortComboList()
        ..isWaitingLoadingInitData.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const BreedingTransactionDetailTopWidget(),
              Obx(
                () => controller.isWaitingLoadingInitData.value
                    ? Expanded(
                        child: LOADING_WIDGET(),
                      )
                    : const BreedingTransactionDetailBodyWidget(),
              ),
            ],
          ),
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
                      controller.isWaitingLoading.value = true;
                      String reasonText = GET_REVIEW_CONTENT(
                        description: controller.cancelDescription.value,
                        quickRateList: controller.quickCancelList,
                      );
                      controller.breedingTransactionModel.status == 'CREATED'
                          ? await BreedingTransactionService.cancelTransaction(
                              id: controller.breedingTransactionId,
                              reasonCancel: reasonText)
                          : await BreedingTransactionService.cancelBreeding(
                              id: controller.breedingTransactionId,
                              reasonCancel: reasonText);

                      controller
                        ..isWaitingLoading.value = false
                        ..isShowCancelPopup.value = false
                        ..onTapNotification = () {
                          controller
                            ..isShowNotificationPopup.value = false
                            ..isShowBottomWidget.value = false
                            ..update();
                        }
                        ..isSuccessNotification = true
                        ..notificationContent =
                            'Cancel transaction successfully.'
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
            () => controller.isShowNotificationPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: controller.onTapNotification ?? () {},
                    content: controller.notificationContent,
                    isSuccessNotification: controller.isSuccessNotification,
                  )
                : const SizedBox.shrink(),
          ),
          const BreedingTransactionDetailWebViewWidget(),
          const BreedingTransactionDetailPopupWidget(),
          const BreedingTransactionDetailReviewPopupWidget(),
          const BreedingTransactionDetailMoreOptionWidget(),
          const BreedingTransactionDetailViewTypeTabWidget(),
          const BreedingTransactionDetailConfirmPopupWidget(),
          const BreedingTransactionViewDetailPopupWidget(),
          Obx(
            () => Visibility(
              visible: controller.isWaitingLoading.value,
              child: Container(
                  color: DARK_GREY_TRANSPARENT, child: LOADING_WIDGET()),
            ),
          ),
        ],
      ),
    );
  }
}
