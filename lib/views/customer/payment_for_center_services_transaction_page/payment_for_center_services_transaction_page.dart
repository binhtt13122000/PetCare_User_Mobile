import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/payment_for_center_services_transaction_page_controller.dart';
import 'package:petapp_mobile/views/customer/payment_for_center_services_transaction_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/payment_for_center_services_transaction_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/payment_for_center_services_transaction_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/payment_for_center_services_transaction_page/widgets/web_view_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PaymentForCenterServicesTransactionPage
    extends GetView<PaymentForCenterServicesTransactionPageController> {
  const PaymentForCenterServicesTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Stack(
          children: [
            Column(
              children: const [
                PaymentForCenterServicesTransactionTopWidget(),
                PaymentForCenterServicesTransactionBodyWidget(),
              ],
            ),
            Obx(() => controller.paymentUrl.value.isNotEmpty
                ? const PaymentForCenterServicesTransactionWebViewWidget()
                : const SizedBox.shrink()),
            Obx(
              () => Visibility(
                visible: controller.isShowPopup.value,
                child: const PaymentForCenterServicesTransactionPopupWidget(),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.isWaitingPayment.value,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  child: LOADING_WIDGET(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
