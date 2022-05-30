import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/sale_transaction_detail_page_controller.dart';

class SaleTransactionPopupWidget
    extends GetView<SaleTransactionDetailPageController> {
  const SaleTransactionPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.isShowPopup.value && !controller.isLoading.value,
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromARGB(106, 201, 188, 190),
            ),
            child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    controller.saleTransactionModel.status == 'SUCCESS'
                        ? 'Payment Successfully'
                        : 'Payment Failed',
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 92, 98, 124),
                      ),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      height: 1,
                      letterSpacing: 1,
                    ),
                  ),
                  Icon(
                    controller.saleTransactionModel.status == 'SUCCESS'
                        ? Icons.verified_outlined
                        : Icons.do_not_disturb_on,
                    size: 70,
                    color: controller.saleTransactionModel.status == 'SUCCESS'
                        ? PRIMARY_COLOR
                        : RED_COLOR,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                      onTap: () => controller.isShowPopup.value = false,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: controller.saleTransactionModel.status ==
                                  'SUCCESS'
                              ? PRIMARY_COLOR
                              : RED_COLOR,
                        ),
                        child: Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(color: WHITE_COLOR),
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            height: 1,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
