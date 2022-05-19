import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/views/customer/transaction_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_page/widgets/top_widget.dart';

class TransactionPage extends GetView<TransactionPageController> {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInPageController _signInPageController =
        Get.find<SignInPageController>();
    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: [
            const TransactionTopWidget(),
            TransactionBodyWidget(
                customerId:
                    _signInPageController.accountModel!.customerModel.id),
          ],
        ),
      ),
    );
  }
}
