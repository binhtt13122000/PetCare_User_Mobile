import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/center_services_transaction_detail_page_controller.dart';

class CenterServicesTransactionDetailBottomWidget
    extends GetView<CenterServicesTransactionDetailPageController> {
  const CenterServicesTransactionDetailBottomWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withAlpha(50),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: InkWell(
                onTap: () {
                  if (controller.orderModel.status == 'WAITING') {
                    Get.toNamed(
                        '$PAYMENT_FOR_CENTER_SERVICES_TRANSACTION_PAGE_ROUTE/${controller.orderModel.id}');
                  } else {
                    controller.isShowReviewPopup.value = true;
                  }
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PRIMARY_COLOR,
                  ),
                  child: Text(
                    controller.orderModel.status == 'WAITING'
                        ? 'Go to payment page'
                        : 'Rate your services experience',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(color: WHITE_COLOR),
                      fontWeight: FontWeight.w600,
                      fontSize:
                          controller.orderModel.status == 'WAITING' ? 18 : 16,
                      height: 1,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
