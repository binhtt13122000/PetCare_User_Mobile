import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/sale_transaction.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';
import 'package:petapp_mobile/services/sale_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PurchaseTransactionTypeWidget extends GetView<TransactionPageController> {
  const PurchaseTransactionTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //purchaseTransactionTypeListWidget(),
        GetBuilder<TransactionPageController>(
          builder: (_) {
            controller.isLoadingPurchaseTransaction.value = true;
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              QueryResult queryResult = await CLIENT_TO_QUERY().query(
                  QueryOptions(
                      document: gql(FETCH_SALE_TRANSACTION_LIST_BY_BUYER_ID),
                      variables: {'customerId': controller.accountModel.id}));
              controller.saleTransactionModelList =
                  SaleTransactionService.getSaleTransactionList(
                      queryResult.data!);
              controller.isLoadingPurchaseTransaction.value = false;
            });
            return Obx(
              () => controller.isLoadingPurchaseTransaction.value
                  ? Expanded(
                      child: Container(
                        color: const Color.fromARGB(106, 198, 188, 201),
                        alignment: Alignment.center,
                        child: const SpinKitSpinningLines(
                          color: PRIMARY_COLOR,
                          size: 150,
                        ),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                      child: Column(
                        children: controller.saleTransactionModelList
                            .asMap()
                            .entries
                            .map((e) => purchaseTransactionItemWidget(
                                saleTransactionModel: e.value))
                            .toList(),
                      ),
                    )),
            );
          },
        ),
      ],
    );
  }

  Widget purchaseTransactionTypeItemWidget(
          {required String purchseTransactionType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () {
              controller.selectedPurchaseTransactionType.value ==
                      purchseTransactionType
                  ? null
                  : controller.selectedPurchaseTransactionType.value =
                      purchseTransactionType;
            },
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedPurchaseTransactionType.value ==
                          purchseTransactionType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          maxRadius: 3,
                          backgroundColor: controller
                                      .selectedPurchaseTransactionType.value ==
                                  purchseTransactionType
                              ? PRIMARY_COLOR
                              : Colors.transparent,
                        ),
                      ),
                      Text(
                        purchseTransactionType,
                        style: GoogleFonts.quicksand(
                          color: controller
                                      .selectedPurchaseTransactionType.value ==
                                  purchseTransactionType
                              ? PRIMARY_COLOR
                              : const Color.fromARGB(255, 116, 122, 143),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  color: controller.selectedPurchaseTransactionType.value ==
                          purchseTransactionType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );

  Widget purchaseTransactionTypeListWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.purchaseTransactionTypeList
              .asMap()
              .entries
              .map((e) => purchaseTransactionTypeItemWidget(
                  purchseTransactionType: e.value))
              .toList(),
        ),
      );

  Widget purchaseTransactionItemWidget(
      {required SaleTransactionModel saleTransactionModel}) {
    late String displayStatus;
    late Color statusColor;
    if (controller.accountModel.customerModel.id ==
        saleTransactionModel.buyerId) {
      switch (saleTransactionModel.status) {
        case 'CREATED':
          displayStatus = 'Waiting to pick up pet and pay';
          statusColor = const Color.fromARGB(255, 247, 203, 60);
          break;
        case 'SUCCESS':
          displayStatus = 'Transaction successfully';
          statusColor = const Color.fromARGB(255, 43, 248, 204);
          break;
        default:
          displayStatus = saleTransactionModel.status;
          statusColor = const Color.fromARGB(255, 43, 248, 204);
      }
    } else {
      switch (saleTransactionModel.status) {
        case 'CREATED':
          displayStatus = 'Waiting for buyer pick up pet';
          statusColor = const Color.fromARGB(255, 247, 203, 60);
          break;
        case 'SUCCESS':
          displayStatus = 'Transaction successfully';
          statusColor = const Color.fromARGB(255, 43, 248, 204);
          break;
        default:
          displayStatus = saleTransactionModel.status;
          statusColor = const Color.fromARGB(255, 43, 248, 204);
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: InkWell(
        onTap: () => Get.toNamed(
            '$SALE_TRANSACTION_DETAIL_PAGE_ROUTE/${saleTransactionModel.id}'),
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 247, 249, 253),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 227, 230, 238),
                blurRadius: 3,
                offset: Offset(3, 3),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Purchase transaction id',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 85, 91, 110),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '#0${saleTransactionModel.id}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 85, 91, 110),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                  // Text(
                  //   'Your role in transaction:',
                  //   textAlign: TextAlign.start,
                  //   style: GoogleFonts.quicksand(
                  //     color: const Color.fromARGB(255, 85, 91, 110),
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 15,
                  //     height: 1,
                  //     letterSpacing: 0.5,
                  //   ),
                  // ),
                  // Text(
                  //   saleTransactionModel.buyerId ==
                  //           controller.accountModel.customerModel.id
                  //       ? '[CUSTOMER]'
                  //       : '[SELLER]',
                  //   textAlign: TextAlign.start,
                  //   style: GoogleFonts.quicksand(
                  //     color: const Color.fromARGB(255, 85, 91, 110),
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 15,
                  //     height: 1,
                  //     letterSpacing: 0.5,
                  //   ),
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    FORMAT_MONEY(price: saleTransactionModel.transactionTotal),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 85, 91, 110),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      height: 1.6,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    saleTransactionModel.point != null &&
                            saleTransactionModel.point != 0
                        ? '+${saleTransactionModel.point} point'
                        : '',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 125, 131, 150),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      height: 1.3,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.selectedPurchaseTransactionType.value ==
                            'Your role in transaction is [BUYER]'
                        ? 'Seller'
                        : 'Buyer',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 125, 131, 150),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1,
                    ),
                  ),
                  Text(
                    controller.selectedPurchaseTransactionType.value ==
                            'Your role in transaction is [BUYER]'
                        ? '${saleTransactionModel.sellerCustomerModel.firstName} ${saleTransactionModel.sellerCustomerModel.lastName}'
                        : '${saleTransactionModel.buyerCustomerModel.firstName} ${saleTransactionModel.buyerCustomerModel.lastName}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 125, 131, 150),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 125, 131, 150),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1,
                    ),
                  ),
                  Text(
                    displayStatus,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      height: 1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    saleTransactionModel.transactionTime != null
                        ? 'Payment time'
                        : 'Meeting time',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 125, 131, 150),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    saleTransactionModel.transactionTime != null
                        ? FORMAT_DATE_TIME(
                            dateTime: saleTransactionModel.transactionTime!,
                            pattern: DATE_TIME_PATTERN)
                        : FORMAT_DATE_TIME(
                            dateTime: saleTransactionModel.meetingTime,
                            pattern: DATE_TIME_PATTERN),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 125, 131, 150),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
