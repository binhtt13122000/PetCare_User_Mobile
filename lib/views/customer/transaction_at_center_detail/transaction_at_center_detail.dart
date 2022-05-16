import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/views/customer/transaction_at_center_detail/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_at_center_detail/widgets/top_widget.dart';

class TransactionAtCenterDetailPage extends GetView {
  const TransactionAtCenterDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: const [
            TransactionAtCenterDetailTopWidget(),
            TransactionAtCenterDetailBottomWidget(),
          ],
        ),
      ),
    );
  }
}
