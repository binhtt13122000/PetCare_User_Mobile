import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/payment_for_center_services_transaction_page_controller.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/center_services_transaction_payment_method_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/center_services_transaction_payment_method_page/widgets/top_widget.dart';

class CenterServicesTransactionPaymentMethodPage
    extends GetView<PaymentForCenterServicesTransactionPageController> {
  const CenterServicesTransactionPaymentMethodPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: const [
            CenterServicesTransactionPaymentMethodTopWidget(),
            CenterServicesTransactionPaymentMethodBodyWidget(),
          ],
        ),
      );
}
