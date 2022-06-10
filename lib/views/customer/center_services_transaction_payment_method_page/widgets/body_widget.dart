import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/payment_for_center_services_transaction_page_controller.dart';

class CenterServicesTransactionPaymentMethodBodyWidget
    extends GetView<PaymentForCenterServicesTransactionPageController> {
  const CenterServicesTransactionPaymentMethodBodyWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Linked account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 62, 68, 87),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  'Edit',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: PRIMARY_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          accountListWidget(),
          Container(
            height: 15,
            color: const Color.fromARGB(255, 242, 244, 247),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Other payment methods',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 62, 68, 87),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          paymentMethodListWidget(),
        ],
      );

  Widget paymentMethodListWidget() => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            paymentMethodWidget(),
            paymentMethodWidget(),
            paymentMethodWidget(),
            paymentMethodWidget(),
          ],
        ),
      );
  Widget paymentMethodWidget({bool isSelected = false}) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          IMAGE_PATH + VNPAY_PNG,
                          height: 25,
                        ),
                      ),
                      Text(
                        'VNPAY Payment Gateway',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 62, 68, 87),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  isSelected
                      ? const Icon(
                          Icons.verified,
                          color: PRIMARY_COLOR,
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withAlpha(30),
            ),
          ],
        ),
      );

  Widget accountListWidget() => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            accountWidget(isSelected: true),
            accountWidget(),
            accountWidget(),
            accountWidget(),
          ],
        ),
      );

  Widget accountWidget({bool isSelected = false}) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image.asset(
                          IMAGE_PATH + VISA_PNG,
                          height: 28,
                        ),
                      ),
                      Text(
                        '1234****5678',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 62, 68, 87),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  isSelected
                      ? const Icon(
                          Icons.verified,
                          color: PRIMARY_COLOR,
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withAlpha(30),
            ),
          ],
        ),
      );
}
