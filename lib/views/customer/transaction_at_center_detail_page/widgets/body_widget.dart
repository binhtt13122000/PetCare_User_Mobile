import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_at_center_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class TransactionAtCenterDetailBodyWidget
    extends GetView<TransactionAtCenterDetailPageController> {
  const TransactionAtCenterDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            transactionInformationWidget(),
            listServices(),
            priceWidget(width: width),
            Container(
              height: 400,
              color: const Color.fromARGB(255, 242, 244, 247),
            ),
          ],
        ),
      ),
    );
  }

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
                backgroundColor: const Color.fromARGB(255, 77, 82, 105),
                child: CircleAvatar(
                  maxRadius: 9,
                  backgroundColor: isDarkBackground
                      ? const Color.fromARGB(255, 242, 244, 247)
                      : WHITE_COLOR,
                  child: Text(
                    '01',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 77, 82, 105),
                      ),
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
                          fontSize: 15,
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

  Widget transactionInformationWidget() => Column(
        children: [
          Container(
            height: 15,
            color: const Color.fromARGB(255, 242, 244, 247),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction ID',
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
                        '#01AxByCz',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 77, 82, 105),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Creation time',
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
                        FORMAT_DATE_TIME(
                            dateTime: DateTime.now(),
                            pattern: DATE_TIME_PATTERN),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 77, 82, 105),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Branch of center',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 77, 82, 105),
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1,
                        ),
                      ),
                      Text(
                        'KNCQ9',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 77, 82, 105),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
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
                        'Wait for pay',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 230, 185, 41),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
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
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 15,
            color: const Color.fromARGB(255, 242, 244, 247),
          ),
        ],
      );

  Widget priceWidget({required double width}) => Stack(
        children: [
          Container(
            height: 60,
            color: WHITE_COLOR,
            child: Column(
              children: [
                Container(
                  height: 1,
                  color: DARK_GREY_COLOR.withAlpha(30),
                  margin: const EdgeInsets.only(bottom: 10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Padding(
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
                            textStyle: const TextStyle(color: PRIMARY_COLOR),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 1,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
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
