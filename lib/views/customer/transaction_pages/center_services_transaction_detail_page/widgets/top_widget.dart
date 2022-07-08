import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/center_services_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/transaction_list_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CenterServicesTransactionDetailTopWidget
    extends GetView<CenterServicesTransactionDetailPageController> {
  const CenterServicesTransactionDetailTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          topWidget(),
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
          ),
        ],
      );

  Widget topWidget() => Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //*back button
            InkWell(
              onTap: () => Get
                ..back()
                ..put(TransactionListPageController())
                ..find<TransactionListPageController>().update(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: DARK_GREY_COLOR.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Color.fromARGB(255, 61, 78, 100),
                  size: 18,
                ),
              ),
            ),
            //*app logo
            Expanded(
              child: CUSTOM_TEXT('Transaction Detail',
                  textAlign: TextAlign.center,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  padding: const EdgeInsets.only(right: 30)),
            ),
          ],
        ),
      );
}
