import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/payment_for_transaction_at_center_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PaymentForTransactionAtCenterBottomWidget
    extends GetView<PaymentForTransactionAtCenterPageController> {
  const PaymentForTransactionAtCenterBottomWidget({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.toNamed(PAYMENT_METHOD_PAGE_ROUNTER),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            IMAGE_PATH + VISA_PNG,
                            height: 28,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '****89',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              textStyle:
                                  const TextStyle(color: PRIMARY_DARK_COLOR),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              height: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SvgPicture.asset(
                            ICON_PATH + UP_ARROW_SVG,
                            height: 14,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 30,
                            width: 1.5,
                            color: LIGHT_GREY_COLOR.withAlpha(60),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            controller.selectedPromotionName.value,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              textStyle: const TextStyle(color: PRIMARY_COLOR),
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              height: 1,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          FORMAT_MONEY(price: 1500000),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 115, 121, 151),
                              decoration: TextDecoration.lineThrough,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            height: 1,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          FORMAT_MONEY(price: 1200000),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              color: PRIMARY_COLOR,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            height: 1,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: PRIMARY_COLOR,
                      ),
                      child: Text(
                        'Payment',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(color: WHITE_COLOR),
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          height: 1,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}