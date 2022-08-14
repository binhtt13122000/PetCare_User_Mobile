import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/sale_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/sale_transaction_services.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/sale_transaction_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/sale_transaction_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/sale_transaction_detail_page/widgets/more_options_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/sale_transaction_detail_page/widgets/review_popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/sale_transaction_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';

class SaleTransactionDetailPage
    extends GetView<SaleTransactionDetailPageController> {
  const SaleTransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['saleTransactionId'] != null) {
      controller.transactionId =
          int.parse(Get.parameters['saleTransactionId']!);
    }
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: GetBuilder<SaleTransactionDetailPageController>(builder: (_) {
        controller.isLoading.value = true;

        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller.saleTransactionModel =
              await SaleTransactionService.fetchSaleTransactionById(
                  jwt: controller.accountModel.jwtToken,
                  saleTransactionId: controller.transactionId);

          controller.isLoading.value = false;
        });
        return Stack(
          children: [
            Column(
              children: [
                const SaleTransactionDetailTopWidget(),
                Obx(
                  () => controller.isLoading.value
                      ? Expanded(
                          child: LOADING_WIDGET(),
                        )
                      : Expanded(
                          child: Column(
                            children: const [
                              SaleTransactionDetailBodyWidget(),
                              SaleTransactionDetailBottomWidget(),
                            ],
                          ),
                        ),
                ),
              ],
            ),
            Obx(
              () => controller.isShowPopup.value
                  ? NotificationPopupWidget(
                      onTapBackground: () {},
                      onTapOk: () => controller
                        ..isShowPopup.value = false
                        ..update(),
                      content: controller.isPaymentSuccess
                          ? 'Payment for transaction #${controller.transactionId} successfully'
                          : 'Payment for transaction #${controller.transactionId} failed',
                      isSuccessNotification: controller.isPaymentSuccess,
                    )
                  : const SizedBox.shrink(),
            ),
            const SaleTransactionReviewPopupWidget(),
            const SaleTransactionMoreOptionWidget(),
            Obx(
              () => controller.isLoadingForeground.value
                  ? Container(
                      color: DARK_GREY_TRANSPARENT, child: LOADING_WIDGET())
                  : const SizedBox.shrink(),
            ),
          ],
        );
      }),
    );
  }
}
