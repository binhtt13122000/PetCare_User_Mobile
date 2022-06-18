import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/payment_for_center_services_transaction_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/center_services_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PaymentForCenterServicesTransactionBottomWidget
    extends GetView<PaymentForCenterServicesTransactionPageController> {
  const PaymentForCenterServicesTransactionBottomWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                children: [
                  paymentMethodWidget(),
                  promotionWidget(),
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
                  paymentMoneyWidget(),
                  paymentWidget(),
                ],
              ),
            ),
          ],
        ),
      );

  Widget promotionWidget() => Expanded(
        child: Obx(
          () => InkWell(
            onTap: () {},
            child: Text(
              controller.selectedPromotionIndex.value != -1
                  ? controller
                      .promotionModels[controller.selectedPromotionIndex.value]
                      .name
                  : 'ADD PROMO',
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
        ),
      );

  Widget paymentMethodWidget() => InkWell(
        onTap: () =>
            Get.toNamed(CENTER_SERVICES_TRANSACTION_PAYMENT_METHOD_PAGE_ROUTE),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                IMAGE_PATH + VNPAY_PNG,
                height: 28,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '****98',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(color: PRIMARY_DARK_COLOR),
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
      );

  Widget paymentMoneyWidget() => Container(
        padding: const EdgeInsets.only(right: 12),
        width: 90,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Visibility(
                visible: controller.discountAmount.value > 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    FORMAT_MONEY(
                        price: controller
                            .centerServicesTransactionModel.provisionalTotal),
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
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  FORMAT_MONEY(
                      price: controller
                              .centerServicesTransactionModel.provisionalTotal -
                          controller.discountAmount.value),
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
              ),
            ],
          ),
        ),
      );

  Widget paymentWidget() => Expanded(
        child: InkWell(
          onTap: () async {
            controller.paymentUrl.value =
                await CenterServicesTransactionServices.payment(
              message: controller.accountModel.customerModel.lastName +
                  'payment ${controller.centerServicesTransactionModel.provisionalTotal - controller.discountAmount.value}',
              locale: 'vi',
              paymentMethod: 'VNPAY',
              transactionId: controller.centerServicesTransactionModel.id,
              orderTotal:
                  controller.centerServicesTransactionModel.provisionalTotal -
                      controller.discountAmount.value,
              paymentTime: DateTime.now(),
              paymentPoint: controller.usedPoint.value,
              promotionId: controller.selectedPromotionIndex.value != -1
                  ? controller
                      .promotionModels[controller.selectedPromotionIndex.value]
                      .id
                  : null,
              customerId: controller.centerServicesTransactionModel.customerId,
              branchId: controller.centerServicesTransactionModel.branchId,
              provisionalTotal:
                  controller.centerServicesTransactionModel.provisionalTotal,
            );
          },
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
      );
}
