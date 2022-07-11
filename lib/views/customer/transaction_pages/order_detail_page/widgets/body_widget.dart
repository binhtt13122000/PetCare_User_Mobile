import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/center_services_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/order_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/order_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class OrderDetailBodyWidget extends GetView<OrderDetailPageController> {
  const OrderDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: GetBuilder<OrderDetailPageController>(builder: (_) {
        controller.isLoadingData.value = true;
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller
            ..orderModel = await OrderServices.fetchOrderIdByOrderId(
                orderId: controller.orderId)
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
                              transactionInformationWidget(),
                              branchInformationWidget(),
                              listServices(),
                              priceWidget(width: width),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          visible: controller.orderModel.status == 'WAITING' ||
                              (controller.orderModel.status == 'SUCCESS' &&
                                  (controller.orderModel.star == null ||
                                      controller.orderModel.star! == 0)),
                          child:
                              const CenterServicesTransactionDetailBottomWidget()),
                      Visibility(
                        visible: controller.orderModel.star != null &&
                            controller.orderModel.star! > 0,
                        child: CUSTOM_TEXT(
                          'You have submitted a review for this transaction',
                          fontSize: 12,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      }),
    );
  }

  Widget viewTransactionDetailWidget() =>
      controller.orderModel.status == 'SUCCESS'
          ? Obx(
              () => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () => controller.isViewTransactionDetail.value =
                      !controller.isViewTransactionDetail.value,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CUSTOM_TEXT(
                          controller.isViewTransactionDetail.value
                              ? 'Hide details'
                              : 'View details',
                          color: PRIMARY_COLOR,
                          fontSize: 13,
                          letterSpacing: 2,
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          controller.isViewTransactionDetail.value
                              ? Icons.keyboard_double_arrow_up_outlined
                              : Icons.keyboard_double_arrow_down_outlined,
                          size: 18,
                          color: PRIMARY_COLOR,
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      width: 120,
                      color: PRIMARY_COLOR,
                      margin: const EdgeInsets.only(top: 2),
                    ),
                  ]),
                ),
              ),
            )
          : const SizedBox.shrink();

  Widget viewBranchDetailWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () => controller.isViewBranchDetail.value =
              !controller.isViewBranchDetail.value,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CUSTOM_TEXT(
                  controller.isViewBranchDetail.value
                      ? 'Hide details'
                      : 'View details',
                  color: PRIMARY_COLOR,
                  fontSize: 13,
                  letterSpacing: 2,
                ),
                const SizedBox(width: 5),
                Icon(
                  controller.isViewBranchDetail.value
                      ? Icons.keyboard_double_arrow_up_outlined
                      : Icons.keyboard_double_arrow_down_outlined,
                  size: 18,
                  color: PRIMARY_COLOR,
                ),
              ],
            ),
            Container(
              height: 1,
              width: 120,
              color: PRIMARY_COLOR,
              margin: const EdgeInsets.only(top: 2),
            ),
          ]),
        ),
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
      type = 'Services';
      itemName = 'Breeding for transaction #' +
          controller.orderModel.orderDetailModelList![index].breedTransactionId
              .toString();
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      color: index.isOdd
          ? DARK_GREY_COLOR.withAlpha(10)
          : DARK_GREY_COLOR.withAlpha(2),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              maxRadius: 11,
              backgroundColor: const Color.fromARGB(255, 179, 181, 190),
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

  Widget listServices() => Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.only(top: 20),
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

  Widget applyPromotionWidget() => controller.orderModel.promotionModel == null
      ? const SizedBox.shrink()
      : Obx(
          () => Visibility(
            visible: controller.isViewTransactionDetail.value,
            child: Column(
              children: [
                Container(
                  height: 1,
                  color: LIGHT_GREY_COLOR.withAlpha(30),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
                CUSTOM_TEXT('Apply promotion',
                    fontSize: 15, padding: const EdgeInsets.only(bottom: 10)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Promotion name',
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
                        controller.orderModel.promotionModel!.name,
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
                        'Discount percent',
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
                        controller.orderModel.promotionModel!.promo.toString() +
                            '%',
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
                        'Used point',
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
                        FORMAT_MONEY_WITHOUT_SYMBOL(
                            price: controller.orderModel.promotionModel!.point),
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
              ],
            ),
          ),
        );

  Widget transactionInformationWidget() {
    late String statusText;
    late Color statusTextColor;
    switch (controller.orderModel.status) {
      case 'WAITING':
        statusText = 'Waiting for payment';
        statusTextColor = YELLOW_COLOR;
        break;
      case 'SUCCESS':
        statusText = 'Transaction completed';
        statusTextColor = GREEN_COLOR;
        break;
      case 'CANCELED':
        statusText = 'Transaction canceled';
        statusTextColor = RED_COLOR;
        break;
      default:
        statusText = controller.orderModel.status;
        statusTextColor = YELLOW_COLOR;
    }
    return Container(
      color: WHITE_COLOR,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Column(
              children: [
                Visibility(
                  visible: controller.isViewTransactionDetail.value ||
                      controller.orderModel.status != 'SUCCESS',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CUSTOM_TEXT(
                          'Created time',
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontSize: 15,
                        ),
                        Text(
                          FORMAT_DATE_TIME(
                              dateTime: DateTime.now(),
                              pattern: DATE_TIME_PATTERN),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            color: const Color.fromARGB(255, 77, 82, 105),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CUSTOM_TEXT(
                        'Transaction status',
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                        fontSize: 15,
                      ),
                      CUSTOM_TEXT(
                        statusText,
                        color: statusTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                controller.orderModel.status == 'CANCELED'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CUSTOM_TEXT(
                              'Cancel time',
                              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              fontSize: 15,
                            ),
                            CUSTOM_TEXT(
                              FORMAT_DATE_TIME(
                                dateTime: controller.orderModel.cancelTime!,
                                pattern: DATE_TIME_PATTERN,
                              ),
                              color: statusTextColor,
                              fontSize: 15,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                paymentInformationWidget(),
                applyPromotionWidget(),
                viewTransactionDetailWidget(),
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

  Widget branchInformationWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: WHITE_COLOR,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            margin: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CUSTOM_TEXT(
                  'Branch perform services',
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  padding: const EdgeInsets.only(bottom: 10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CUSTOM_TEXT(
                        'Branch name',
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                        fontSize: 15,
                      ),
                      CUSTOM_TEXT(
                        controller.orderModel.branchModel!.name,
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                        fontSize: 15,
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CUSTOM_TEXT(
                          'Address',
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontSize: 15,
                        ),
                        Expanded(
                          child: CUSTOM_TEXT(
                              controller.orderModel.branchModel!.address!,
                              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              fontSize: 15,
                              textOverflow: controller.isViewBranchDetail.value
                                  ? TextOverflow.clip
                                  : TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              padding: const EdgeInsets.only(left: 15)),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isViewBranchDetail.value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CUSTOM_TEXT(
                            'Phone number',
                            color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                            fontSize: 15,
                          ),
                          CUSTOM_TEXT(
                            controller.orderModel.branchModel!.phoneNumber,
                            color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isViewBranchDetail.value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CUSTOM_TEXT(
                            'Email',
                            color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                            fontSize: 15,
                          ),
                          CUSTOM_TEXT(
                            controller.orderModel.branchModel!.email ?? 'N/A',
                            color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                viewBranchDetailWidget(),
              ],
            ),
          ),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
        ],
      );

  Widget paymentInformationWidget() => Visibility(
        visible: controller.orderModel.status == 'SUCCESS',
        child: Obx(
          () => Column(
            children: [
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
                      controller.orderModel.paymentTime != null
                          ? FORMAT_DATE_TIME(
                              dateTime: controller.orderModel.paymentTime!,
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
                      controller.orderModel.paymentMethod ?? '',
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
              Visibility(
                visible: controller.isViewTransactionDetail.value,
                child: Padding(
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
                            price: controller.orderModel.provisionalTotal),
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
              ),
              Visibility(
                visible: controller.isViewTransactionDetail.value,
                child: Padding(
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
                        '-${FORMAT_MONEY(price: controller.orderModel.provisionalTotal - controller.orderModel.orderTotal)}',
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
                      FORMAT_MONEY(price: controller.orderModel.orderTotal),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        color: PRIMARY_COLOR,
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
                        CUSTOM_TEXT(
                          FORMAT_MONEY(
                              price: controller.orderModel.provisionalTotal),
                          textAlign: TextAlign.center,
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          textDecoration:
                              controller.orderModel.status == 'CANCELED'
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
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
                color: SUPPER_LIGHT_BLUE,
              ),
            ),
          ),
        ],
      );
}
