import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/payment_for_transaction_at_center_page_controller.dart';
import 'package:petapp_mobile/views/customer/payment_for_transaction_at_center/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/payment_for_transaction_at_center/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/payment_for_transaction_at_center/widgets/top_widget.dart';

class PaymentForTransactionAtCenterPage
    extends GetView<PaymentForTransactionAtCenterPageController> {
  const PaymentForTransactionAtCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: const [
            PaymentForTransactionAtCenterTopWidget(),
            PaymentForTransactionAtCenterBodyWidget(),
            PaymentForTransactionAtCenterBottomWidget(),
          ],
        ),
      ),
    );
  }
}
