import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_list_page_controller.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';
import 'package:petapp_mobile/services/sale_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class SaleTransactionListWidget extends GetView<TransactionListPageController> {
  const SaleTransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          purchaseTransactionTypeListWidget(),
          Expanded(
            child: GetBuilder<TransactionListPageController>(
              builder: (_) {
                controller.isLoadingPurchaseTransaction.value = true;
                WidgetsBinding.instance!.addPostFrameCallback((_) async {
                  controller.saleTransactionModelList =
                      await SaleTransactionService.fecthSaleTransactionList(
                    buyerId: controller.selectedPurchaseTransactionType.value ==
                            'Transaction role: [BUYER]'
                        ? controller.accountModel.customerModel.id.toString()
                        : null,
                    sellerId: controller
                                .selectedPurchaseTransactionType.value ==
                            'Transaction role: [SELLER]'
                        ? controller.accountModel.customerModel.id.toString()
                        : null,
                    page: controller.page.toString(),
                    limit: controller.limit.toString(),
                  );
                  controller.isLoadingPurchaseTransaction.value = false;
                });
                return Obx(
                  () => controller.isLoadingPurchaseTransaction.value
                      ? const SpinKitSpinningLines(
                          color: PRIMARY_COLOR,
                          size: 150,
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: controller.saleTransactionModelList
                                .asMap()
                                .entries
                                .map((e) => purchaseTransactionItemWidget(
                                    saleTransactionModel: e.value))
                                .toList(),
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget purchaseTransactionTypeItemWidget(
          {required String purchseTransactionType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () => controller
              ..selectedPurchaseTransactionType.value = purchseTransactionType
              ..update(),
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
                          fontSize: 13,
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
                    'Transaction id',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
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
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total price',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    FORMAT_MONEY(price: saleTransactionModel.transactionTotal),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.quicksand(
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      height: 1,
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
                            'Transaction role: [BUYER]'
                        ? 'Seller'
                        : 'Buyer',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1,
                    ),
                  ),
                  Text(
                    controller.selectedPurchaseTransactionType.value ==
                            'Transaction role: [BUYER]'
                        ? '${saleTransactionModel.sellerCustomerModel.firstName} ${saleTransactionModel.sellerCustomerModel.lastName}'
                        : '${saleTransactionModel.buyerCustomerModel.firstName} ${saleTransactionModel.buyerCustomerModel.lastName}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
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
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
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
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
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
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
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
