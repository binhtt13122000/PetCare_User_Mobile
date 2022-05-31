import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/payment_for_transaction_at_center_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
//import 'package:petapp_mobile/views/customer/payment_for_transaction_at_center/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/payment_for_transaction_at_center/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/payment_for_transaction_at_center/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/payment_for_transaction_at_center/widgets/web_view_widget.dart';

class PaymentForTransactionAtCenterPage
    extends GetView<PaymentForTransactionAtCenterPageController> {
  const PaymentForTransactionAtCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              Column(
                children: const [
                  PaymentForTransactionAtCenterTopWidget(),
                  //PaymentForTransactionAtCenterBodyWidget(),
                ],
              ),
              Obx(
                () => Visibility(
                  visible: controller.paymentUrl.value.isNotEmpty,
                  child: const WebViewWidget(),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isShowPopup.value,
                  child: const PaymentForTransactionAtCenterPopupWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
