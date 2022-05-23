import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_at_center_detail_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/views/customer/transaction_at_center_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_at_center_detail_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_at_center_detail_page/widgets/review_popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_at_center_detail_page/widgets/top_widget.dart';

class TransactionAtCenterDetailPage
    extends GetView<TransactionAtCenterDetailPageController> {
  const TransactionAtCenterDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: const [
                  TransactionAtCenterDetailTopWidget(),
                  TransactionAtCenterDetailBodyWidget(),
                ],
              ),
            ),
            const ReviewPopupWidget(),
            const TransactionAtCenterDetailPopupWidget(),
          ],
        ),
      ),
    );
  }
}
