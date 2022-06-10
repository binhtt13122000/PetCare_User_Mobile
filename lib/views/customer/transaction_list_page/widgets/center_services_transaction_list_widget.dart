import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/transaction_list_page_controller.dart';
import 'package:petapp_mobile/models/center_services_transaction_model/center_services_transaction_model.dart';
import 'package:petapp_mobile/services/center_services_transaction_services.dart';
import 'package:petapp_mobile/services/customer_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CenterServicesTransactionListWidget
    extends GetView<TransactionListPageController> {
  const CenterServicesTransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionListPageController>(builder: (_) {
      controller.isLoadingCenterServicesTransaction.value = true;
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        controller
          ..centerServicesTransactionList =
              await CenterServicesTransactionServices
                  .fetchListCenterServicesTransactionByCustomerId(
            page: controller.page,
            limit: controller.limit,
            customerId: controller.accountModel.customerModel.id,
          )
          ..accountModel.customerModel =
              await CustomerService.fetchCustomerById(
                  controller.accountModel.customerModel.id);
        Get.find<AuthController>().accountModel.customerModel =
            controller.accountModel.customerModel;
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
                        .map((e) => centerServicesItemWidget(
                            centerServicesTransactionModel: e.value))
                        .toList(),
                  ),
                ),
              ),
      ));
    });
  }

  Widget centerServicesItemWidget(
      {required CenterServicesTransactionModel
          centerServicesTransactionModel}) {
    late String timeText;
    late DateTime timeValue;
    switch (centerServicesTransactionModel.status) {
      case 'SUCCESS':
        timeText = 'Payment time';
        timeValue = centerServicesTransactionModel.paymentTime!;
        break;
      default:
        timeText = 'Create time';
        timeValue = centerServicesTransactionModel.registerTime;
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: InkWell(
        onTap: () => Get.toNamed(
            '$CENTER_SERVICES_TRANSACTION_DETAIL_PAGE_ROUTE/${centerServicesTransactionModel.id}'),
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
                  CUSTOM_TEXT(
                    'Transaction id',
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 12,
                  ),
                  CUSTOM_TEXT(
                    '#0${centerServicesTransactionModel.id}',
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CUSTOM_TEXT(
                    'Branch name',
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 12,
                  ),
                  CUSTOM_TEXT(
                    centerServicesTransactionModel.branchModel!.name,
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CUSTOM_TEXT(
                    centerServicesTransactionModel.status == 'WAITING'
                        ? 'Provisional total'
                        : 'Transaction total',
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 15,
                  ),
                  CUSTOM_TEXT(
                    FORMAT_MONEY(
                      price: centerServicesTransactionModel.status == 'WAITING'
                          ? centerServicesTransactionModel.provisionalTotal
                          : centerServicesTransactionModel.orderTotal,
                    ),
                    color: PRIMARY_COLOR,
                    fontSize: 20,
                    letterSpacing: 1,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CUSTOM_TEXT(
                    'Status: ',
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 15,
                  ),
                  CUSTOM_TEXT(
                    centerServicesTransactionModel.status == 'WAITING'
                        ? 'Waiting for payment'
                        : 'Transaction is completed',
                    color: centerServicesTransactionModel.status == 'WAITING'
                        ? const Color.fromARGB(255, 250, 199, 30)
                        : const Color.fromARGB(255, 25, 221, 205),
                    fontSize: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CUSTOM_TEXT(
                    timeText,
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 13,
                  ),
                  CUSTOM_TEXT(
                    FORMAT_DATE_TIME(
                        dateTime: timeValue, pattern: DATE_TIME_PATTERN),
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 13,
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
