import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/deposit_page_controller.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class DepositPage extends GetView<DepositPageController> {
  const DepositPage({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: DARK_GREY_COLOR.withAlpha(30),
                child: Column(
                  children: [
                    topWidget(),
                    Container(
                      height: 1,
                      color: DARK_GREY_COLOR.withAlpha(30),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            postDetail(),
                            Container(
                              color: WHITE_COLOR,
                              height: 230,
                              width: width,
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
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
                                        textStyle: TextStyle(
                                            color:
                                                DARK_GREY_COLOR.withAlpha(180)),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 80,
                                    ),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: DARK_GREY_COLOR,
                                          maxRadius: 3,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Buyer make a deposit',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                                color: DARK_GREY_COLOR
                                                    .withAlpha(180)),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 80,
                                    ),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: DARK_GREY_COLOR,
                                          maxRadius: 3,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Waiting for the seller bring \nthe pet to the center',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                                color: DARK_GREY_COLOR
                                                    .withAlpha(180)),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 80,
                                    ),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: DARK_GREY_COLOR,
                                          maxRadius: 3,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Buyers come to the center \nand check the pet',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                                color: DARK_GREY_COLOR
                                                    .withAlpha(180)),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 80,
                                    ),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: DARK_GREY_COLOR,
                                          maxRadius: 3,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Buyer pays the rest and \ngets the pet',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                                color: DARK_GREY_COLOR
                                                    .withAlpha(180)),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  color: WHITE_COLOR,
                                  height: 100,
                                  margin: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                ICON_PATH + CHAT_SVG,
                                                height: 20,
                                                color: DARK_GREY_COLOR
                                                    .withAlpha(160)),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Contact to the store\'s staff',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(
                                                    color: DARK_GREY_COLOR
                                                        .withAlpha(160)),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        color: DARK_GREY_COLOR.withAlpha(30),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Discount amount',
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                        color: DARK_GREY_COLOR
                                                            .withAlpha(180)),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    height: 1,
                                                  ),
                                                ),
                                                Text(
                                                  FORMAT_MONEY(
                                                      price: (postModel
                                                                  .provisionalTotal /
                                                              100 *
                                                              5)
                                                          .toInt()),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.quicksand(
                                                    textStyle: const TextStyle(
                                                        color: DARK_GREY_COLOR),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    height: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total price',
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                        color: DARK_GREY_COLOR
                                                            .withAlpha(180)),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    height: 1,
                                                  ),
                                                ),
                                                Text(
                                                  FORMAT_MONEY(
                                                      price: (postModel
                                                                  .provisionalTotal /
                                                              100 *
                                                              95)
                                                          .toInt()),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.quicksand(
                                                    textStyle: const TextStyle(
                                                        color: PRIMARY_COLOR),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    height: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                rhombusItemListWidget(screenWidth: width),
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  promotionItemWidget(),
                                  promotionItemWidget(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: DARK_GREY_COLOR.withAlpha(30),
                    ),
                    bottomWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: WHITE_COLOR,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //*back button
            InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                ICON_PATH + BACK_SVG,
                color: PRIMARY_COLOR,
                height: 17,
              ),
            ),
            //*app logo
            Expanded(
              child: Text(
                'Payment Page',
                textAlign: TextAlign.center,
                style: GoogleFonts.satisfy(
                  textStyle: const TextStyle(color: PRIMARY_COLOR),
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      );

  Widget postDetail() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                postModel.mediaModels![0].url,
                height: 100,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postModel.petModel!.name +
                        ' (' +
                        postModel.petModel!.breedModel.name +
                        ' - ' +
                        postModel.petModel!.breedModel.speciesModel!.name +
                        ')',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      textStyle:
                          TextStyle(color: DARK_GREY_COLOR.withAlpha(220)),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deposit',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle:
                              TextStyle(color: DARK_GREY_COLOR.withAlpha(180)),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1,
                        ),
                      ),
                      // Text(
                      //   FORMAT_MONEY(price: postModel.deposit!),
                      //   textAlign: TextAlign.center,
                      //   style: GoogleFonts.quicksand(
                      //     textStyle:
                      //         TextStyle(color: DARK_GREY_COLOR.withAlpha(190)),
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: 16,
                      //     height: 1,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle:
                              TextStyle(color: DARK_GREY_COLOR.withAlpha(180)),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1,
                        ),
                      ),
                      Text(
                        FORMAT_MONEY(price: postModel.provisionalTotal),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          textStyle:
                              TextStyle(color: DARK_GREY_COLOR.withAlpha(190)),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget bottomWidget() => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
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
                          '5565',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            textStyle:
                                const TextStyle(color: PRIMARY_DARK_COLOR),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Text(
                          'ADD A PROMO',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(color: PRIMARY_COLOR),
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deposit',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(color: LIGHT_GREY_COLOR),
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          height: 1,
                        ),
                      ),
                      // Text(
                      //   FORMAT_MONEY(price: postModel.deposit!),
                      //   textAlign: TextAlign.center,
                      //   style: GoogleFonts.quicksand(
                      //     textStyle: const TextStyle(color: PRIMARY_DARK_COLOR),
                      //     fontWeight: FontWeight.w700,
                      //     fontSize: 22,
                      //     height: 1,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  width: 200,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
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
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );

  Widget promotionItemWidget() => Stack(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Row(
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
                      decoration: const BoxDecoration(
                        color: WHITE_COLOR,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VS1605',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  color: DARK_GREY_COLOR.withAlpha(180)),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              height: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Visa discount 5%',
                            textAlign: TextAlign.center,
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
                            'Exp.Date: 16/05/2021',
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
                      decoration: const BoxDecoration(
                        color: WHITE_COLOR,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Select',
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
            ],
          ),
          Positioned(
            top: 30,
            right: 64.5,
            child: SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 1,
                    color: LIGHT_GREY_COLOR,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 5,
                    width: 1,
                    color: LIGHT_GREY_COLOR,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 5,
                    width: 1,
                    color: LIGHT_GREY_COLOR,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 5,
                    width: 1,
                    color: LIGHT_GREY_COLOR,
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget rhombusItemListWidget({required double screenWidth}) {
    List<Widget> listRhombus = [rhombusItemWidget()];
    int numberOfRhombus = screenWidth ~/ 10;

    do {
      numberOfRhombus--;
      listRhombus.add(rhombusItemWidget());
    } while (numberOfRhombus > 0);

    return Positioned(
      bottom: 5,
      child: Row(children: listRhombus),
    );
  }

  Widget rhombusItemWidget() => RotationTransition(
        turns: const AlwaysStoppedAnimation(45 / 360),
        child: Container(
          height: 10,
          width: 10,
          color: WHITE_COLOR,
        ),
      );
}
