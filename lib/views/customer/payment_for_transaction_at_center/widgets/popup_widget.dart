import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/payment_for_transaction_at_center_page_controller.dart';

class PaymentForTransactionAtCenterPopupWidget
    extends GetView<PaymentForTransactionAtCenterPageController> {
  const PaymentForTransactionAtCenterPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
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
                'Payment Successfully',
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
              const Icon(
                Icons.verified_outlined,
                size: 70,
                color: PRIMARY_COLOR,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: InkWell(
                  onTap: () => Get.toNamed(
                      '$TRANSACTION_AT_CENTER_DETAIL_PAGE_ROUNTER/${controller.normalTransactionModel.id}'),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: PRIMARY_COLOR,
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
      );
}
