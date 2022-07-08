import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/payment_for_center_services_transaction_page_controller.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';
import 'package:petapp_mobile/services/transaction_services/center_services_transaction_services.dart';
import 'package:petapp_mobile/services/transaction_services/promotion_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/payment_for_center_services_transaction_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PaymentForCenterServicesTransactionBodyWidget
    extends GetView<PaymentForCenterServicesTransactionPageController> {
  const PaymentForCenterServicesTransactionBodyWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: GetBuilder<PaymentForCenterServicesTransactionPageController>(
        builder: (_) {
          controller.isLoadingData.value = true;
          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            controller
              ..orderModel = await CenterServicesTransactionServices
                  .fetchCenterServicesTransactionByTransactionId(
                      transactionId:
                          int.parse(Get.parameters['transactionId']!))
              ..promotionModels =
                  await PromotionServices.fetchPromotionByBranchId(
                      branchId: controller.orderModel.branchId)
              ..isLoadingData.value = false;
          });
          return Obx(
            () => controller.isLoadingData.value
                ? LOADING_WIDGET()
                : Container(
                    color: SUPPER_LIGHT_BLUE,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                listServices(),
                                Container(
                                  height: 1,
                                  color: LIGHT_GREY_COLOR.withAlpha(30),
                                ),
                                pointWidget(),
                                listPromotionWidget(),
                                priceWidget(width: width),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                        const PaymentForCenterServicesTransactionBottomWidget(),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget pointWidget() => Container(
        color: WHITE_COLOR,
        margin: const EdgeInsets.only(top: 10),
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CUSTOM_TEXT('Your points', fontSize: 15),
                    CUSTOM_TEXT(
                      FORMAT_MONEY_WITHOUT_SYMBOL(
                          price: controller.accountModel.customerModel.point),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CUSTOM_TEXT('Used points', fontSize: 15),
                    CUSTOM_TEXT(
                      '- ' +
                          FORMAT_MONEY_WITHOUT_SYMBOL(
                              price: controller.usedPoint.value),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CUSTOM_TEXT('Remaining points', fontSize: 15),
                    CUSTOM_TEXT(
                      FORMAT_MONEY_WITHOUT_SYMBOL(
                          price: controller.accountModel.customerModel.point -
                              controller.usedPoint.value),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: LIGHT_GREY_COLOR.withAlpha(30),
                margin: const EdgeInsets.only(top: 10),
              ),
            ],
          ),
        ),
      );

  Widget listPromotionWidget() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.promotionModels
              .asMap()
              .entries
              .map(
                (e) =>
                    promotionItemWidget(index: e.key, promotionModel: e.value),
              )
              .toList(),
        ),
      );

  Widget listServices() => Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: WHITE_COLOR,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 32,
                    child: CUSTOM_TEXT(
                      'No.',
                      textAlign: TextAlign.start,
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 70,
                    child: CUSTOM_TEXT(
                      'Type',
                      textAlign: TextAlign.start,
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                      fontSize: 15,
                    ),
                  ),
                  Expanded(
                    child: CUSTOM_TEXT('Item name',
                        textAlign: TextAlign.start,
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                        fontSize: 15,
                        padding: const EdgeInsets.only(left: 10)),
                  ),
                  CUSTOM_TEXT(
                    'Price',
                    textAlign: TextAlign.center,
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                    fontSize: 15,
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
              children: controller.orderModel.orderDetailModelList!
                  .asMap()
                  .entries
                  .map(
                    (e) => serviceItemWidget(index: e.key),
                  )
                  .toList(),
            ),
          ],
        ),
      );

  Widget priceWidget({required double width}) => Column(
        children: [
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
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
                                FORMAT_MONEY(
                                    price:
                                        controller.orderModel.provisionalTotal),
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
                                  '- ${FORMAT_MONEY(price: (controller.discountAmount.value))}',
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
                                Obx(
                                  () => Text(
                                    FORMAT_MONEY(
                                        price: controller
                                                .orderModel.provisionalTotal -
                                            controller.discountAmount.value),
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

  Widget serviceItemWidget({
    required int index,
  }) {
    late String type;
    late String itemName;

    if (controller.orderModel.orderDetailModelList![index].petComboId != null) {
      type = 'Combo';
      itemName = controller.orderModel.orderDetailModelList![index]
          .petComboModel!.servicesComboModel!.name;
    } else if (controller.orderModel.orderDetailModelList![index].serviceId !=
        null) {
      type = 'Services';
      itemName = controller
          .orderModel.orderDetailModelList![index].centerServiceModel!.name;
    } else {
      type = 'Breeding';
      itemName = 'Breeding transaction #' +
          controller.orderModel.orderDetailModelList![index].breedTransactionId
              .toString();
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      color: index.isOdd ? PRIMARY_COLOR.withAlpha(5) : WHITE_COLOR,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              maxRadius: 11,
              backgroundColor: const Color.fromARGB(255, 159, 164, 187),
              child: CircleAvatar(
                maxRadius: 10,
                backgroundColor: index.isOdd
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
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 70,
            child: CUSTOM_TEXT(
              type,
              textAlign: TextAlign.start,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
              fontSize: 15,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CUSTOM_TEXT(
                    itemName,
                    textOverflow: TextOverflow.clip,
                    textAlign: TextAlign.start,
                    fontSize: 15,
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 70,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: CUSTOM_TEXT(
                      FORMAT_MONEY(
                          price: controller.orderModel
                              .orderDetailModelList![index].totalPrice),
                      textAlign: TextAlign.end,
                      fontSize: 15,
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                      //       fontWeight: FontWeight.w700,
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

  Widget promotionItemWidget(
          {required PromotionModel promotionModel, required int index}) =>
      Visibility(
        visible: promotionModel.expireTime.isAfter(DateTime.now()) &&
            promotionModel.startTime.isBefore(DateTime.now()),
        child: Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 7,
                          height: 90,
                          decoration: const BoxDecoration(
                            color: PRIMARY_COLOR,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(5),
                            ),
                          ),
                        ),
                        Container(
                          width: 210,
                          height: 90,
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            color:
                                controller.selectedPromotionIndex.value == index
                                    ? PRIMARY_COLOR.withOpacity(0.1)
                                    : WHITE_COLOR,
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(20),
                            ),
                            border: Border.all(
                              color: controller.selectedPromotionIndex.value ==
                                      index
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
                                'DISCOUNT ${promotionModel.promo}%',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.quicksand(
                                  color: const Color.fromARGB(255, 77, 82, 105),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  height: 1,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Apply money: ${FORMAT_MONEY(price: promotionModel.applyMoney)}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  color:
                                      const Color.fromARGB(255, 127, 133, 161),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Required point: ${FORMAT_MONEY_WITHOUT_SYMBOL(price: promotionModel.point)}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  color:
                                      const Color.fromARGB(255, 127, 133, 161),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  height: 1,
                                ),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // Text(
                              //   'Exp.Date: ${FORMAT_DATE_TIME(dateTime: promotionModel.expireTime, pattern: DATE_PATTERN)}',
                              //   textAlign: TextAlign.center,
                              //   style: GoogleFonts.quicksand(
                              //     color:
                              //         const Color.fromARGB(255, 127, 133, 161),
                              //     fontWeight: FontWeight.w500,
                              //     fontSize: 13,
                              //     height: 1,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.selectedPromotionIndex.value !=
                                    index &&
                                promotionModel.applyMoney <=
                                    controller.orderModel.provisionalTotal &&
                                controller.accountModel.customerModel.point >=
                                    promotionModel.point) {
                              int discountMoney =
                                  (controller.orderModel.provisionalTotal /
                                          100 *
                                          promotionModel.promo)
                                      .toInt();

                              controller
                                ..selectedPromotionIndex.value = index
                                ..discountAmount.value =
                                    discountMoney > promotionModel.maxMoneyPromo
                                        ? promotionModel.maxMoneyPromo
                                        : discountMoney
                                ..usedPoint.value = promotionModel.point;
                            } else {
                              controller
                                ..selectedPromotionIndex.value = -1
                                ..discountAmount.value = 0
                                ..usedPoint.value = 0;
                            }
                          },
                          child: Container(
                            width: 60,
                            height: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.selectedPromotionIndex.value ==
                                      index
                                  ? PRIMARY_COLOR.withOpacity(0.1)
                                  : WHITE_COLOR,
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(5),
                              ),
                              border: Border.all(
                                color:
                                    controller.selectedPromotionIndex.value ==
                                            index
                                        ? PRIMARY_COLOR
                                        : Colors.transparent,
                              ),
                            ),
                            child: Text(
                              controller.selectedPromotionIndex.value == index
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 69.5,
              child: SizedBox(
                height: 150,
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 1,
                        color: controller.selectedPromotionIndex.value == index
                            ? WHITE_COLOR
                            : LIGHT_GREY_COLOR,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        height: 5,
                        width: 1,
                        color: controller.selectedPromotionIndex.value == index
                            ? WHITE_COLOR
                            : LIGHT_GREY_COLOR,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        height: 5,
                        width: 1,
                        color: controller.selectedPromotionIndex.value == index
                            ? WHITE_COLOR
                            : LIGHT_GREY_COLOR,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        height: 5,
                        width: 1,
                        color: controller.selectedPromotionIndex.value == index
                            ? WHITE_COLOR
                            : LIGHT_GREY_COLOR,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: promotionModel.applyMoney >
                      controller.orderModel.provisionalTotal ||
                  controller.accountModel.customerModel.point <
                      promotionModel.point,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 7,
                          height: 90,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR.withOpacity(0.7),
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(5),
                            ),
                          ),
                        ),
                        Container(
                          width: 210,
                          height: 90,
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            color: WHITE_COLOR.withOpacity(0.7),
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(20),
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR.withOpacity(0.7),
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(5),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                color: SUPPER_LIGHT_BLUE,
              ),
            ),
          ),
        ],
      );
}
