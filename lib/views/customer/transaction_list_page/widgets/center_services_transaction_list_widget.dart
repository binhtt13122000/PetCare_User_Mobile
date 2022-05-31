import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_list_page_controller.dart';
import 'package:petapp_mobile/models/center_services_transaction_model/center_services_transaction_model.dart';
import 'package:petapp_mobile/services/center_services_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class CenterServicesTransactionListWidget
    extends GetView<TransactionListPageController> {
  const CenterServicesTransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionListPageController>(builder: (_) {
      controller.isLoadingCenterServicesTransaction.value = true;
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        controller.centerServicesTransactionList =
            await CenterServicesTransactionServices
                .fetchListCenterServicesTransactionBuyCustomerId(
          page: controller.page,
          limit: controller.limit,
          customerId: controller.accountModel.customerModel.id,
        );
        controller.isLoadingCenterServicesTransaction.value = false;
      });

      return Expanded(
          child: Obx(
        () => controller.isLoadingCenterServicesTransaction.value
            ? const SpinKitSpinningLines(
                color: PRIMARY_COLOR,
                size: 150,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: controller.centerServicesTransactionList
                        .asMap()
                        .entries
                        .map((e) => normalTransactionItemWidget(
                            centerServicesTransactionModel: e.value))
                        .toList(),
                  ),
                ),
              ),
      ));
    });
  }

  Widget normalTransactionItemWidget(
          {required CenterServicesTransactionModel
              centerServicesTransactionModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: InkWell(
          onTap: () => Get.toNamed(
              '$TRANSACTION_AT_CENTER_DETAIL_PAGE_ROUTE/${centerServicesTransactionModel.id}'),
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
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            '#0${centerServicesTransactionModel.id}',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.quicksand(
                              color: const Color.fromARGB(255, 85, 91, 110),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              height: 1,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Text(
                          //'Branch: ${centerServicesTransactionModel.branchModel.representativeName}',
                          'Branch name',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.quicksand(
                            color: const Color.fromARGB(255, 85, 91, 110),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            height: 1,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Status: ',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.quicksand(
                            color: const Color.fromARGB(255, 125, 131, 150),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            height: 1,
                          ),
                        ),
                        Text(
                          centerServicesTransactionModel.status == 'WAITING'
                              ? 'WAITING FOR PAY'
                              : 'PAYMENT SUCCESS',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.quicksand(
                            color: centerServicesTransactionModel.status ==
                                    'WAITING'
                                ? const Color.fromARGB(255, 250, 199, 30)
                                : const Color.fromARGB(255, 25, 221, 205),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${FORMAT_DATE_TIME(dateTime: centerServicesTransactionModel.paymentTime ?? DateTime.now(), pattern: DATE_TIME_PATTERN)}',
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        FORMAT_MONEY(
                            price: centerServicesTransactionModel.orderTotal),
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
                        '+${centerServicesTransactionModel.point ?? 0} point',
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
                ),
              ],
            ),
          ),
        ),
      );
}
