import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/breeding_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionDetailBottomWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Visibility(
              visible:
                  controller.breedingTransactionModel.status == 'CREATED' &&
                      controller.breedingTransactionModel.ownerPetFemaleId ==
                          controller.accountModel.customerModel.id,
              child: paymentWidget(),
            ),
            Visibility(
              visible:
                  controller.breedingTransactionModel.status == 'SUCCESS' &&
                      (controller.breedingTransactionModel.star == null ||
                          controller.breedingTransactionModel.star == 0) &&
                      controller.breedingTransactionModel.ownerPetFemaleId ==
                          controller.accountModel.customerModel.id,
              child: ratingWidget(),
            ),
            Visibility(
              visible:
                  controller.breedingTransactionModel.status == 'SUCCESS' &&
                      (controller.breedingTransactionModel.star != null &&
                          controller.breedingTransactionModel.star! > 0) &&
                      controller.breedingTransactionModel.ownerPetFemaleId ==
                          controller.accountModel.customerModel.id,
              child: CUSTOM_TEXT(
                'You have submitted a review for this transaction',
                fontSize: 12,
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );

  Widget ratingWidget() => Column(
        children: [
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(50),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () async {
                controller.isShowReviewPopup.value = true;
              },
              child: Container(
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: PRIMARY_COLOR,
                ),
                child: Text(
                  'Rate Your Transaction Experience',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(color: WHITE_COLOR),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    height: 1,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget paymentWidget() => Column(
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
                  onTap: () => Get.toNamed(PAYMENT_METHOD_PAGE_ROUTE),
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
                      Text(
                        FORMAT_MONEY(
                            price: controller
                                .breedingTransactionModel.transactionTotal),
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: PRIMARY_COLOR,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          height: 1,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () async {
                controller.paymentUrl.value =
                    await BreedingTransactionService.payment(
                        id: controller.breedingTransactionModel.id,
                        transactionTime: DateTime.now(),
                        transactionTotal: controller
                            .breedingTransactionModel.transactionTotal,
                        locale: 'vi',
                        paymentMethod: 'VNPAY',
                        message:
                            'Customer #0${controller.accountModel.customerModel.id} payment for breeding transaction #0${controller.breedingTransactionModel.id}');
              },
              child: Container(
                height: 45,
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
          ),
        ],
      );
}
