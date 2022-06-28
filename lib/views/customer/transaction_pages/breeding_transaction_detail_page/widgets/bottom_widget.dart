import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionDetailBottomWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      color: WHITE_COLOR,
      child:
          controller.breedingTransactionModel.ownerPetFemaleCustomerModel.id ==
                  controller.accountModel.customerModel.id
              ? femalePetBottomWidget()
              : malePetBottomWidget());

  Widget malePetBottomWidget() => Column(
        children: const [],
      );

  Widget femalePetBottomWidget() => Column(
        children: [
          Visibility(
            visible: controller.breedingTransactionModel.status == 'CREATED',
            child: paymentWidget(),
          ),
          Visibility(
            visible: controller.breedingTransactionModel.paymentTime != null &&
                (controller.breedingTransactionModel.star == null ||
                    controller.breedingTransactionModel.star == 0),
            child: ratingWidget(),
          ),
          Visibility(
            visible: controller.breedingTransactionModel.star != null &&
                controller.breedingTransactionModel.star! > 0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: SUPPER_LIGHT_BLUE,
                    alignment: Alignment.center,
                    child: CUSTOM_TEXT(
                      'You have submitted a review for this transaction',
                      fontSize: 12,
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
                controller
                  ..reviewType = 'TRANSACTION_REVIEW'
                  ..isShowReviewPopup.value = true;
              },
              child: Container(
                height: 35,
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
                    fontSize: 13,
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
                  onTap: () => Get.toNamed(
                      CENTER_SERVICES_TRANSACTION_PAYMENT_METHOD_PAGE_ROUTE),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
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
                            textStyle:
                                const TextStyle(color: PRIMARY_DARK_COLOR),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            height: 1,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          ICON_PATH + UP_ARROW_SVG,
                          height: 14,
                        ),
                        const SizedBox(
                          width: 10,
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
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
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
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () async {
                controller.isWaitingForeground.value = true;
                await BreedingTransactionService.quickPayment(
                    id: controller.breedingTransactionModel.id,
                    paymentForMalePetOwnerTime: DateTime.now());
                controller
                  ..isWaitingForeground.value = false
                  ..popupTitle = 'Payment successfully!'
                  ..isShowPopup.value = true;
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
