import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_at_center_detail_page_controller.dart';
import 'package:petapp_mobile/views/customer/transaction_at_center_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_at_center_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_at_center_detail_page/widgets/top_widget.dart';

class TransactionAtCenterDetailPage
    extends GetView<TransactionAtCenterDetailPageController> {
  const TransactionAtCenterDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: const [
            TransactionAtCenterDetailTopWidget(),
            TransactionAtCenterDetailBodyWidget(),
            TransactionAtCenterDetailBottomWidget(),
          ],
        ),
      ),
    );
  }
}
