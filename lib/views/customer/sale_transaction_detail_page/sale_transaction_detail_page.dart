import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/sale_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/sale_transaction.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/review_popup_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/web_view.dart';

class SaleTransactionDetailPage
    extends GetView<SaleTransactionDetailPageController> {
  const SaleTransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: GetBuilder<SaleTransactionDetailPageController>(builder: (_) {
        controller.isLoading.value = true;

        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          QueryResult result = await CLIENT_TO_QUERY().query(
            QueryOptions(
                document: gql(FETCH_SALE_TRANSACTION_BY_ID),
                variables: {
                  'id': Get.parameters['saleTransactionId'],
                }),
          );
          controller.saleTransactionModel = SaleTransactionModel.fromJson(
              result.data!['sale_transaction'][0]);
          controller.isLoading.value = false;
        });
        return Obx(
          () => controller.isLoading.value
              ? Container(
                  color: const Color.fromARGB(106, 198, 188, 201),
                  alignment: Alignment.center,
                  child: const SpinKitSpinningLines(
                    color: PRIMARY_COLOR,
                    size: 150,
                  ),
                )
              : Stack(
                  children: [
                    Column(
                      children: const [
                        SaleTransactionDetailTopWidget(),
                        //PurchaseTransactionDetaiBodyWidget(),
                        SaleTransactionDetailBottomWidget(),
                      ],
                    ),
                    const SaleTransactionDetailWebViewWidget(),
                    const SaleTransactionPopupWidget(),
                    const SaleTransactionReviewPopupWidget(),
                  ],
                ),
        );
      }),
    );
  }
}
