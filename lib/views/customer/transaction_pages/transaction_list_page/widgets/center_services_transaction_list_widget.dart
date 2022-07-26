import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/transaction_list_page_controller.dart';
import 'package:petapp_mobile/models/order_model/order_model.dart';
import 'package:petapp_mobile/services/transaction_services/order_services.dart';
import 'package:petapp_mobile/services/other_services/customer_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CenterServicesTransactionListWidget
    extends GetView<TransactionListPageController> {
  const CenterServicesTransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionListPageController>(builder: (_) {
      controller.isLoadingCenterServicesTransaction.value = true;
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        controller
          ..orderModelList = await OrderServices
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
            ? LOADING_WIDGET()
            : SmartRefresher(
                controller: RefreshController(),
                onRefresh: () => controller.update(),
                child: controller.orderModelList.isEmpty
                    ? NO_DATA_WIDGET(
                        content:
                            'Sorry, no center services \ntransaction data found.')
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: controller.orderModelList
                                .asMap()
                                .entries
                                .map((e) => centerServicesItemWidget(
                                    centerServicesTransactionModel: e.value))
                                .toList(),
                          ),
                        ),
                      ),
              ),
      ));
    });
  }

  Widget centerServicesItemWidget(
      {required OrderModel centerServicesTransactionModel}) {
    late String timeText;
    late DateTime timeValue;
    late String statusText;
    late Color statusColor;
    switch (centerServicesTransactionModel.status) {
      case 'SUCCESS':
        timeText = 'Payment time';
        timeValue = centerServicesTransactionModel.paymentTime!;
        statusText = 'Transaction is completed';
        statusColor = GREEN_COLOR;
        break;
      case 'CANCELED':
        timeText = 'Create time';
        timeValue = centerServicesTransactionModel.registerTime;
        statusText = 'Transaction is canceled';
        statusColor = RED_COLOR;

        break;
      case 'EXPIRED':
        timeText = 'Create time';
        timeValue = centerServicesTransactionModel.registerTime;
        statusText = 'Transaction is expired';
        statusColor = YELLOW_COLOR;
        break;
      case 'WAITING':
        timeText = 'Create time';
        timeValue = centerServicesTransactionModel.registerTime;
        statusText = 'Waiting for payment';
        statusColor = YELLOW_COLOR;
        break;
      default:
        timeText = 'Create time';
        timeValue = centerServicesTransactionModel.registerTime;
        statusText = centerServicesTransactionModel.status;
        statusColor = YELLOW_COLOR;

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
                    'Perform branch',
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
                        : 'Total price',
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
                    statusText,
                    color: statusColor,
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
