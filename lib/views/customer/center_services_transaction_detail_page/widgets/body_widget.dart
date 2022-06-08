import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/center_services_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/models/center_services_transaction_detail_model/center_services_transaction_detail_model.dart';
import 'package:petapp_mobile/services/center_services_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/center_services_transaction_detail_page/widgets/bottom_widget.dart';

class CenterServicesTransactionDetailBodyWidget
    extends GetView<CenterServicesTransactionDetailPageController> {
  const CenterServicesTransactionDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: GetBuilder<CenterServicesTransactionDetailPageController>(
          builder: (_) {
        controller.isLoadingData.value = true;
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller.centerServicesTransactionModel =
              await CenterServicesTransactionServices
                  .fetchCenterServicesTransactionByCustomerId(
                      transactionId:
                          int.parse(Get.parameters['transactionId']!));
          controller.isLoadingData.value = false;
        });
        return Obx(
          () => controller.isLoadingData.value
              ? const Center(
                  child: SpinKitSpinningLines(
                    color: PRIMARY_COLOR,
                    size: 150,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
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
                    ),
                    Visibility(
                        visible: controller
                                    .centerServicesTransactionModel.status ==
                                'WAITING' ||
                            (controller.centerServicesTransactionModel.star ==
                                0),
                        child:
                            const CenterServicesTransactionDetailBottomWidget()),
                  ],
                ),
        );
      }),
    );
  }

  Widget serviceItemWidget(
          {required bool isDarkBackground,
          required int index,
          required CenterServicesTransactionDetailModel
              centerServicesTransactionDetailModel}) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        color: isDarkBackground
            ? const Color.fromARGB(255, 242, 244, 247)
            : WHITE_COLOR,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                maxRadius: 11,
                backgroundColor: const Color.fromARGB(255, 159, 164, 187),
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: isDarkBackground
                      ? const Color.fromARGB(255, 242, 244, 247)
                      : WHITE_COLOR,
                  child: Text(
                    index <= 9 ? '0${index + 1}' : '${index + 1}',
                    textAlign: TextAlign.center,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          centerServicesTransactionDetailModel
                              .centerServiceModel.name,
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
                          centerServicesTransactionDetailModel.description ??
                              '',
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                  ),
                  Text(
                    FORMAT_MONEY(
                        price: centerServicesTransactionDetailModel.price),
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
            Column(
              children: controller.centerServicesTransactionModel
                  .centerServicesTransactionDetailModelList!
                  .asMap()
                  .entries
                  .map(
                    (e) => serviceItemWidget(
                      index: e.key,
                      isDarkBackground: e.key.isOdd,
                      centerServicesTransactionDetailModel: e.value,
                    ),
                  )
                  .toList(),
            ),
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
                        '#0${controller.centerServicesTransactionModel.id}',
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
                        controller
                            .centerServicesTransactionModel.branchModel!.name,
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
                        controller.centerServicesTransactionModel.status ==
                                'WAITING'
                            ? 'WAITING FOR PAY'
                            : 'PAYMENT SUCCESS',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: controller
                                      .centerServicesTransactionModel.status ==
                                  'WAITING'
                              ? const Color.fromARGB(255, 250, 199, 30)
                              : const Color.fromARGB(255, 25, 221, 205),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: controller.centerServicesTransactionModel.status ==
                      'SUCCESS',
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        color: DARK_GREY_COLOR.withAlpha(30),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment time',
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
                              controller.centerServicesTransactionModel
                                          .paymentTime !=
                                      null
                                  ? FORMAT_DATE_TIME(
                                      dateTime: controller
                                          .centerServicesTransactionModel
                                          .paymentTime!,
                                      pattern: DATE_TIME_PATTERN)
                                  : '',
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
                              'Payment method',
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
                              controller.centerServicesTransactionModel
                                      .paymentMethod ??
                                  '',
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
                              'Provisional total',
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
                              FORMAT_MONEY(
                                  price: controller
                                      .centerServicesTransactionModel
                                      .provisionalTotal),
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
                              'Discount amount',
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
                              '-${FORMAT_MONEY(price: controller.centerServicesTransactionModel.provisionalTotal - controller.centerServicesTransactionModel.orderTotal)}',
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
                              'Total price',
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
                              FORMAT_MONEY(
                                  price: controller
                                      .centerServicesTransactionModel
                                      .orderTotal),
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
                              'Money paid',
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
                              controller.centerServicesTransactionModel
                                          .payment !=
                                      null
                                  ? FORMAT_MONEY(
                                      price: controller
                                          .centerServicesTransactionModel
                                          .payment!)
                                  : '',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                color: PRIMARY_COLOR,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
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
                          FORMAT_MONEY(
                              price: controller.centerServicesTransactionModel
                                  .provisionalTotal),
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
