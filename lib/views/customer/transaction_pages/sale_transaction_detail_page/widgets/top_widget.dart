import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/sale_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/transaction_list_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SaleTransactionDetailTopWidget
    extends GetView<SaleTransactionDetailPageController> {
  const SaleTransactionDetailTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            topTitleWidget(),
            Container(
              height: 1,
              margin: const EdgeInsets.only(top: 20),
              color: LIGHT_GREY_COLOR.withOpacity(0.1),
            ),
            transactionIdWidget(),
          ],
        ),
      );

  Widget transactionIdWidget() => Container(
        color: SUPPER_LIGHT_BLUE,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(
              'Transaction ID',
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
            CUSTOM_TEXT(
              (controller.transactionId < 10 ? '#0' : '#') +
                  controller.transactionId.toString(),
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
          ],
        ),
      );

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
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
            Expanded(
              child: Text(
                'Sale Transaction Page',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 62, 68, 87),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? const SizedBox(
                      width: 35,
                    )
                  : Visibility(
                      visible:
                          controller.saleTransactionModel.status == 'CREATED',
                      child: InkWell(
                        onTap: () => controller.isShowMoreOptions.value = true,
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
                          child: SvgPicture.asset(
                            ICON_PATH + ELLIPSIS_SVG,
                            color: DARK_GREY_TEXT_COLOR,
                            height: 16,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
}
