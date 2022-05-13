import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/payment_pay_controller.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PaymentBodyWidget extends GetView<PaymentPageController> {
  const PaymentBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            postGeneralInfoWidget(),
            tipWidget(width: width),
            priceWidget(width: width),
            Container(
              color: const Color.fromARGB(255, 242, 244, 247),
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

  Widget priceWidget({required double width}) => Stack(
        children: [
          Container(
            height: 120,
            color: const Color.fromARGB(255, 250, 251, 255),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 7),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ICON_PATH + CHAT_SVG,
                        height: 18,
                        color: const Color.fromARGB(255, 100, 105, 129),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Contact to the seller',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 100, 105, 129),
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: DARK_GREY_COLOR.withAlpha(30),
                  margin: const EdgeInsets.only(top: 7, bottom: 10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
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
                                textStyle:
                                    const TextStyle(color: DARK_GREY_COLOR),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
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
                              FORMAT_MONEY(
                                  price:
                                      (controller.postModel.provisionalTotal /
                                              100 *
                                              95)
                                          .toInt()),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                textStyle:
                                    const TextStyle(color: PRIMARY_COLOR),
                                fontWeight: FontWeight.w700,
                                fontSize: 19,
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
                    margin: const EdgeInsets.only(top: 20),
                    color: const Color.fromARGB(255, 242, 244, 247),
                  ),
                ),
              ],
            ),
          ),
          rhombusItemListWidget(screenWidth: width),
        ],
      );

  Widget tipWidget({required double width}) => Column(
        children: [
          SizedBox(
            height: 200,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                    left: 40,
                  ),
                  child: Text(
                    'Steps to buy a pet:',
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
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 70,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 137, 141, 161),
                          maxRadius: 6,
                          child: CircleAvatar(
                            maxRadius: 5,
                            backgroundColor:
                                const Color.fromARGB(255, 250, 251, 255),
                            child: Text(
                              '1',
                              style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 100, 105, 129),
                                ),
                                fontWeight: FontWeight.w900,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'The seller confirms the order',
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 70,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 137, 141, 161),
                          maxRadius: 6,
                          child: CircleAvatar(
                            maxRadius: 5,
                            backgroundColor:
                                const Color.fromARGB(255, 250, 251, 255),
                            child: Text(
                              '2',
                              style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 100, 105, 129),
                                ),
                                fontWeight: FontWeight.w900,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Buyer arrives at the scheduled\nappointment to pick up the pet',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 77, 82, 105),
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1.3,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 70,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 137, 141, 161),
                          maxRadius: 6,
                          child: CircleAvatar(
                            maxRadius: 5,
                            backgroundColor:
                                const Color.fromARGB(255, 250, 251, 255),
                            child: Text(
                              '3',
                              style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 100, 105, 129),
                                ),
                                fontWeight: FontWeight.w900,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Buyer inspects the pet and \nproceeds to pay',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 77, 82, 105),
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1.3,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 70,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 137, 141, 161),
                          maxRadius: 6,
                          child: CircleAvatar(
                            maxRadius: 5,
                            backgroundColor:
                                const Color.fromARGB(255, 250, 251, 255),
                            child: Text(
                              '4',
                              style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 100, 105, 129),
                                ),
                                fontWeight: FontWeight.w900,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Transaction completed',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 77, 82, 105),
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1.3,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10),
            color: DARK_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 15,
            color: const Color.fromARGB(255, 242, 244, 247),
          ),
        ],
      );

  Widget postGeneralInfoWidget() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 146, 152, 179),
                    ),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      controller.postModel.mediaModels![0].url,
                      height: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pet breed',
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
                              controller.postModel.petModel!.breedModel.name +
                                  ' - ' +
                                  controller.postModel.petModel!.breedModel
                                      .speciesModel!.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 77, 82, 105),
                                ),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
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
                              'Pet name',
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
                              controller.postModel.petModel!.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 77, 82, 105),
                                ),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                height: 1,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 0.5,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          color: const Color.fromARGB(255, 209, 213, 233),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Deposit',
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
                              FORMAT_MONEY(price: 0),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
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
                              FORMAT_MONEY(
                                  price: controller.postModel.provisionalTotal),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10),
            color: DARK_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 15,
            color: const Color.fromARGB(255, 242, 244, 247),
          ),
        ],
      );

  Widget promotionItemWidget({required PromotionModel promotionModel}) => Stack(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: InkWell(
                  onTap: () {
                    if (controller.selectedPromotionName.value !=
                        promotionModel.name) {
                      controller.selectedPromotion = promotionModel;
                      controller.disccountAmount.value =
                          (controller.postModel.provisionalTotal /
                                  100 *
                                  promotionModel.discountPercent)
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
                                : const Color.fromARGB(255, 250, 251, 255),
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
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 77, 82, 105),
                                  ),
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
                                  textStyle:
                                      const TextStyle(color: DARK_GREY_COLOR),
                                  fontWeight: FontWeight.w800,
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
                                  textStyle: TextStyle(
                                      color: DARK_GREY_COLOR.withAlpha(150)),
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
                                : const Color.fromARGB(255, 250, 251, 255),
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
                              textStyle: const TextStyle(color: PRIMARY_COLOR),
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
              height: 110,
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
      bottom: 5,
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
