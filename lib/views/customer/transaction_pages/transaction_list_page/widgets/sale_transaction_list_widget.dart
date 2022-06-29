import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/transaction_list_page_controller.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';
import 'package:petapp_mobile/services/other_services/customer_services.dart';
import 'package:petapp_mobile/services/transaction_services/sale_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SaleTransactionListWidget extends GetView<TransactionListPageController> {
  const SaleTransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          saleTransactionTypeListWidget(),
          Expanded(
            child: GetBuilder<TransactionListPageController>(
              builder: (_) {
                controller.isLoadingSaleTransaction.value = true;
                WidgetsBinding.instance!.addPostFrameCallback((_) async {
                  controller
                    ..saleTransactionModelList =
                        await SaleTransactionService.fetchSaleTransactionList(
                      buyerId: controller.selectedSaleTransactionType.value ==
                              'Transaction role: [BUYER]'
                          ? controller.accountModel.customerModel.id.toString()
                          : null,
                      sellerId: controller.selectedSaleTransactionType.value ==
                              'Transaction role: [SELLER]'
                          ? controller.accountModel.customerModel.id.toString()
                          : null,
                      page: controller.page.toString(),
                      limit: controller.limit.toString(),
                    )
                    ..accountModel.customerModel =
                        await CustomerService.fetchCustomerById(
                            controller.accountModel.customerModel.id);
                  Get.find<AuthController>().accountModel.customerModel =
                      controller.accountModel.customerModel;
                  controller.isLoadingSaleTransaction.value = false;
                });
                return Obx(
                  () => controller.isLoadingSaleTransaction.value
                      ? const SpinKitSpinningLines(
                          color: PRIMARY_COLOR,
                          size: 150,
                        )
                      : controller.saleTransactionModelList.isEmpty
                          ? NO_DATA_WIDGET(
                              content: 'Sorry, no sale transaction data found.')
                          : SingleChildScrollView(
                              child: Column(
                                children: controller.saleTransactionModelList
                                    .asMap()
                                    .entries
                                    .map((e) => saleTransactionItemWidget(
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

  Widget saleTransactionTypeItemWidget(
          {required String saleTransactionType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () => controller
              ..selectedSaleTransactionType.value = saleTransactionType
              ..update(),
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedSaleTransactionType.value ==
                          saleTransactionType
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
                          backgroundColor:
                              controller.selectedSaleTransactionType.value ==
                                      saleTransactionType
                                  ? PRIMARY_COLOR
                                  : Colors.transparent,
                        ),
                      ),
                      Text(
                        saleTransactionType,
                        style: GoogleFonts.quicksand(
                          color: controller.selectedSaleTransactionType.value ==
                                  saleTransactionType
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
                  color: controller.selectedSaleTransactionType.value ==
                          saleTransactionType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );

  Widget saleTransactionTypeListWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.saleTransactionTypeList
              .asMap()
              .entries
              .map((e) =>
                  saleTransactionTypeItemWidget(saleTransactionType: e.value))
              .toList(),
        ),
      );

  Widget saleTransactionItemWidget(
      {required SaleTransactionModel saleTransactionModel}) {
    late String displayStatus;
    late Color statusColor;
    late String timeTitle;
    late DateTime timeValue;

    if (controller.accountModel.customerModel.id ==
        saleTransactionModel.buyerId) {
      switch (saleTransactionModel.status) {
        case 'CREATED':
          displayStatus = 'Waiting to pick up pet and pay';
          statusColor = YELLOW_COLOR;
          timeTitle = 'Meeting time';
          timeValue = saleTransactionModel.meetingTime;
          break;
        case 'CANCELED':
          displayStatus = 'The transaction has been canceled';
          statusColor = RED_COLOR;
          timeTitle = 'Cancel time';
          timeValue = DateTime.now();
          break;
        case 'SUCCESS':
          displayStatus = 'The transaction is completed';
          statusColor = GREEN_COLOR;
          timeTitle = 'Payment time';
          timeValue = saleTransactionModel.transactionTime!;
          break;

        default:
          timeTitle = 'Payment time';
          timeValue = saleTransactionModel.transactionTime!;
          displayStatus = saleTransactionModel.status;
          statusColor = GREEN_COLOR;
      }
    } else {
      switch (saleTransactionModel.status) {
        case 'CREATED':
          displayStatus = 'Waiting for meeting with buyer';
          statusColor = YELLOW_COLOR;
          timeTitle = 'Meeting time';
          timeValue = saleTransactionModel.meetingTime;
          break;
        case 'CANCELED':
          displayStatus = 'The transaction has been canceled';

          statusColor = RED_COLOR;
          timeTitle = 'Cancel time';
          timeValue = DateTime.now();
          break;
        case 'SUCCESS':
          displayStatus = 'The transaction is completed';
          statusColor = GREEN_COLOR;
          timeTitle = 'Payment time';
          timeValue = saleTransactionModel.transactionTime!;
          break;
        default:
          displayStatus = saleTransactionModel.status;
          statusColor = GREEN_COLOR;
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
                    controller.selectedSaleTransactionType.value ==
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
                    controller.selectedSaleTransactionType.value ==
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
                    timeTitle,
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
                    FORMAT_DATE_TIME(
                        dateTime: timeValue, pattern: DATE_TIME_PATTERN),
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
