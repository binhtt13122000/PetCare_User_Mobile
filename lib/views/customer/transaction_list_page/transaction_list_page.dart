import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_list_page_controller.dart';
import 'package:petapp_mobile/views/customer/transaction_list_page/widgets/center_services_transaction_list_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_list_page/widgets/sale_transaction_list_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_list_page/widgets/top_widget.dart';

class TransactionListPage extends GetView<TransactionListPageController> {
  const TransactionListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Obx(() {
        return Column(
          children: [
            const TransactionListTopWidget(),
            controller.selectedTransactionType.value == 'Center\'s services'
                ? const CenterServicesTransactionListWidget()
                : const SizedBox.shrink(),
            controller.selectedTransactionType.value == 'Sale'
                ? const SaleTransactionListWidget()
                : const SizedBox.shrink(),
          ],
        );
      }),
    );
  }
}
