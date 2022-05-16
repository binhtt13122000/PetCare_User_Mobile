import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/payment_for_transaction_at_center_page_controller.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PaymentForTransactionAtCenterBodyWidget
    extends GetView<PaymentForTransactionAtCenterPageController> {
  const PaymentForTransactionAtCenterBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              color: const Color.fromARGB(255, 242, 244, 247),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction ID',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 126, 128, 138),
                      ),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '#01AxByCz',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 126, 128, 138),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            listServices(),
            priceWidget(width: width),
            Container(
              height: 400,
              color: const Color.fromARGB(255, 242, 244, 247),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.promotionModels
                      .asMap()
                      .entries
                      .map(
                        (e) => promotionItemWidget(promotionModel: e.value),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listServices() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: Text(
                          'No.',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.quicksand(
                            color: const Color.fromARGB(255, 85, 91, 110),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            height: 1,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Text(
                        'Services Used',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 85, 91, 110),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Price',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 85, 91, 110),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: DARK_GREY_COLOR.withAlpha(30),
            ),
            serviceItemWidget(),
            serviceItemWidget(isDarkBackground: true),
            serviceItemWidget(),
            serviceItemWidget(isDarkBackground: true),
          ],
        ),
      );

  Widget priceWidget({required double width}) => Column(
        children: [
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 15,
            color: const Color.fromARGB(255, 242, 244, 247),
          ),
          Stack(
            children: [
              Container(
                height: 110,
                color: WHITE_COLOR,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Provisional total',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 77, 82, 105),
                                  ),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  height: 1,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                '${FORMAT_MONEY(price: (1500000))}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  color: const Color.fromARGB(255, 77, 82, 105),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  height: 1,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount amount',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 77, 82, 105),
                                  ),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  height: 1,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  '- ${FORMAT_MONEY(price: (controller.disccountAmount.value))}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.quicksand(
                                    color:
                                        const Color.fromARGB(255, 77, 82, 105),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    height: 1,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 0.5,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            color: const Color.fromARGB(255, 209, 213, 233),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total price',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 77, 82, 105),
                                    ),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    height: 1,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Text(
                                  FORMAT_MONEY(price: (1200000).toInt()),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.quicksand(
                                    textStyle:
                                        const TextStyle(color: PRIMARY_COLOR),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    height: 1,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 0),
                        color: const Color.fromARGB(255, 242, 244, 247),
                      ),
                    ),
                  ],
                ),
              ),
              rhombusItemListWidget(screenWidth: width),
            ],
          ),
        ],
      );

  Widget serviceItemWidget({bool isDarkBackground = false}) => Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        color: isDarkBackground
            ? const Color.fromARGB(255, 242, 244, 247)
            : WHITE_COLOR,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                maxRadius: 10,
                backgroundColor: const Color.fromARGB(255, 145, 151, 173),
                child: CircleAvatar(
                  maxRadius: 9,
                  backgroundColor: isDarkBackground
                      ? const Color.fromARGB(255, 242, 244, 247)
                      : WHITE_COLOR,
                  child: Text(
                    '01',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 103, 106, 122),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Grooming',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 77, 82, 105),
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Grooming for a Husky dog',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 77, 82, 105),
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.5,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    FORMAT_MONEY(price: 123123),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 77, 82, 105),
                      ),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget promotionItemWidget({required PromotionModel promotionModel}) => Stack(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: InkWell(
                  onTap: () {
                    if (controller.selectedPromotionName.value !=
                        promotionModel.name) {
                      controller.selectedPromotion = promotionModel;
                      controller.disccountAmount.value =
                          (1000000 / 100 * promotionModel.discountPercent)
                              .toInt();
                      controller.selectedPromotionName.value =
                          promotionModel.name;
                    } else {
                      controller.selectedPromotion = null;
                      controller.disccountAmount.value = 0;
                      controller.selectedPromotionName.value = 'ADD A PROMO';
                    }
                  },
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 7,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: PRIMARY_COLOR,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(5),
                            ),
                          ),
                        ),
                        Container(
                          width: 210,
                          height: 80,
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            color: controller.selectedPromotionName.value ==
                                    promotionModel.name
                                ? PRIMARY_COLOR.withOpacity(0.1)
                                : WHITE_COLOR,
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(10),
                            ),
                            border: Border.all(
                              color: controller.selectedPromotionName.value ==
                                      promotionModel.name
                                  ? PRIMARY_COLOR
                                  : Colors.transparent,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                promotionModel.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  color: const Color.fromARGB(255, 77, 82, 105),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                promotionModel.description,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.quicksand(
                                  color: const Color.fromARGB(255, 77, 82, 105),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Exp.Date: ${FORMAT_DATE_TIME(dateTime: promotionModel.expDate, pattern: DATE_PATTERN)}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  color:
                                      const Color.fromARGB(255, 127, 133, 161),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 55,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: controller.selectedPromotionName.value ==
                                    promotionModel.name
                                ? PRIMARY_COLOR.withOpacity(0.1)
                                : WHITE_COLOR,
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(10),
                              right: Radius.circular(5),
                            ),
                            border: Border.all(
                              color: controller.selectedPromotionName.value ==
                                      promotionModel.name
                                  ? PRIMARY_COLOR
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            controller.selectedPromotionName.value ==
                                    promotionModel.name
                                ? 'Cancel'
                                : 'Select',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              color: PRIMARY_COLOR,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              height: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 64.5,
            child: SizedBox(
              height: 140,
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 1,
                      color: controller.selectedPromotionName.value ==
                              promotionModel.name
                          ? WHITE_COLOR
                          : LIGHT_GREY_COLOR,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: 5,
                      width: 1,
                      color: controller.selectedPromotionName.value ==
                              promotionModel.name
                          ? WHITE_COLOR
                          : LIGHT_GREY_COLOR,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: 5,
                      width: 1,
                      color: controller.selectedPromotionName.value ==
                              promotionModel.name
                          ? WHITE_COLOR
                          : LIGHT_GREY_COLOR,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: 5,
                      width: 1,
                      color: controller.selectedPromotionName.value ==
                              promotionModel.name
                          ? WHITE_COLOR
                          : LIGHT_GREY_COLOR,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget rhombusItemListWidget({required double screenWidth}) {
    List<Widget> listRhombus = [rhombusItemWidget()];
    int numberOfRhombus = screenWidth ~/ 8;

    do {
      numberOfRhombus--;
      listRhombus.add(rhombusItemWidget());
    } while (numberOfRhombus > 0);

    return Positioned(
      bottom: 0,
      child: Row(children: listRhombus),
    );
  }

  Widget rhombusItemWidget() => Stack(
        children: [
          Container(
            height: 8,
            width: 9,
            alignment: Alignment.topCenter,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: Container(
                height: 7,
                width: 7,
                color: DARK_GREY_COLOR.withAlpha(50),
              ),
            ),
          ),
          Container(
            height: 8,
            width: 9,
            alignment: Alignment.bottomCenter,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: Container(
                height: 7,
                width: 7,
                color: const Color.fromARGB(255, 242, 244, 247),
              ),
            ),
          ),
        ],
      );
}
