import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionDetailWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<BreedingTransactionDetailPageController>(builder: (_) {
      controller.isWaitingLoadingTransactionDetailTab.value = true;

      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        controller
          ..breedingTransactionModel =
              await BreedingTransactionService.fetchBreedingTransactionById(
                  breedingTransactionId: controller.breedingTransactionId)
          ..isWaitingLoadingTransactionDetailTab.value = false
          ..isShowTransactionDetailBottom.value = true;
      });
      return Obx(() => controller.isWaitingLoadingTransactionDetailTab.value
          ? Padding(
              padding: const EdgeInsets.only(top: 150),
              child: LOADING_WIDGET(size: 90),
            )
          : Column(
              children: [
                breedingTransactionInformationWidget(),
                saleTransactionPriceWidget(width: width),
              ],
            ));
    });
  }

  Widget saleTransactionPriceWidget({required double width}) => Stack(
        children: [
          Column(
            children: [
              Container(
                color: WHITE_COLOR,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.breedingTransactionModel
                                      .ownerPetFemaleId ==
                                  controller.accountModel.customerModel.id
                              ? 'Provisional total'
                              : 'Transaction total price',
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 77, 82, 105),
                          ),
                        ),
                        Text(
                          FORMAT_MONEY(
                              price: controller
                                  .breedingTransactionModel.transactionTotal),
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 77, 82, 105),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: controller
                              .breedingTransactionModel.ownerPetFemaleId ==
                          controller.accountModel.customerModel.id,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Fees charged ',
                                style: GoogleFonts.quicksand(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 77, 82, 105),
                                ),
                              ),
                              Icon(
                                Icons.info_outline_rounded,
                                size: 15,
                                color: DARK_GREY_COLOR.withAlpha(100),
                              ),
                            ],
                          ),
                          Text(
                            FORMAT_MONEY(price: 0),
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 77, 82, 105),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller
                              .breedingTransactionModel.ownerPetFemaleId !=
                          controller.accountModel.customerModel.id,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Transaction fees',
                                style: GoogleFonts.quicksand(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 77, 82, 105),
                                ),
                              ),
                              Icon(
                                Icons.info_outline_rounded,
                                size: 15,
                                color: DARK_GREY_COLOR.withAlpha(100),
                              ),
                            ],
                          ),
                          Text(
                            FORMAT_MONEY(
                              price: controller
                                  .breedingTransactionModel.transactionFee,
                            ),
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 77, 82, 105),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      height: 1,
                      color: DARK_GREY_COLOR.withAlpha(150),
                    ),
                    Visibility(
                      visible: controller
                              .breedingTransactionModel.ownerPetFemaleId ==
                          controller.accountModel.customerModel.id,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total price',
                            style: GoogleFonts.quicksand(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 77, 82, 105),
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            FORMAT_MONEY(
                                price: controller
                                    .breedingTransactionModel.transactionTotal),
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: PRIMARY_COLOR,
                              letterSpacing: 1,
                              decoration:
                                  controller.breedingTransactionModel.status ==
                                              'CANCELED' ||
                                          controller.breedingTransactionModel
                                                  .status ==
                                              'REJECTED'
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller
                              .breedingTransactionModel.ownerPetFemaleId !=
                          controller.accountModel.customerModel.id,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Received money',
                            style: GoogleFonts.quicksand(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 77, 82, 105),
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            FORMAT_MONEY(
                                price: controller.breedingTransactionModel
                                        .transactionTotal -
                                    controller.breedingTransactionModel
                                        .transactionFee),
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: PRIMARY_COLOR,
                              letterSpacing: 1,
                              decoration:
                                  controller.breedingTransactionModel.status ==
                                              'CANCELED' ||
                                          controller.breedingTransactionModel
                                                  .status ==
                                              'REJECTED'
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: WHITE_COLOR,
                height: 10,
              ),
              Container(
                color: const Color.fromARGB(255, 245, 248, 253),
                height: 16,
              ),
            ],
          ),
          rhombusItemListWidget(screenWidth: width),
        ],
      );

  Widget breedingTransactionInformationWidget() {
    late String displayStatus;
    late Color statusColor;
    if (controller.accountModel.customerModel.id ==
        controller.breedingTransactionModel.ownerPetFemaleId) {
      switch (controller.breedingTransactionModel.status) {
        case 'CREATED':
          displayStatus = 'Waiting to pick up pet and pay';
          statusColor = YELLOW_COLOR;
          break;
        case 'CANCELED':
          displayStatus = 'The transaction has been canceled';
          statusColor = RED_COLOR;
          break;
        case 'SUCCESS':
          displayStatus = 'The transaction is completed';
          statusColor = GREEN_COLOR;
          break;

        default:
          displayStatus = controller.breedingTransactionModel.status;
          statusColor = GREEN_COLOR;
      }
    } else {
      switch (controller.breedingTransactionModel.status) {
        case 'CREATED':
          displayStatus = 'Waiting for meeting with buyer';
          statusColor = YELLOW_COLOR;
          break;
        case 'CANCELED':
          displayStatus = 'The transaction has been canceled';
          statusColor = RED_COLOR;
          break;
        case 'SUCCESS':
          displayStatus = 'The transaction is completed';
          statusColor = GREEN_COLOR;
          break;
        default:
          displayStatus = 'The transaction is completed';
          statusColor = GREEN_COLOR;
      }
    }
    return Column(
      children: [
        Container(
          color: WHITE_COLOR,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your transaction role',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 77, 82, 105),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    controller.breedingTransactionModel.ownerPetFemaleId ==
                            controller.accountModel.customerModel.id
                        ? '[BUYER]'
                        : '[SELLER]',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: PRIMARY_COLOR,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create time',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 77, 82, 105),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    FORMAT_DATE_TIME(
                        dateTime:
                            controller.breedingTransactionModel.createdTime,
                        pattern: DATE_TIME_PATTERN),
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 77, 82, 105),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 77, 82, 105),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    displayStatus,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible:
                    controller.breedingTransactionModel.status == 'CANCELED',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        'Reason cancel',
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 77, 82, 105),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.breedingTransactionModel.reasonCancel ?? '',
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: RED_COLOR.withOpacity(0.8),
                          letterSpacing: 0.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                height: 1,
                color: DARK_GREY_COLOR.withAlpha(50),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Meeting time',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 77, 82, 105),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    FORMAT_DATE_TIME(
                        dateTime:
                            controller.breedingTransactionModel.meetingTime,
                        pattern: DATE_TIME_PATTERN),
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 77, 82, 105),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Meeting place',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 77, 82, 105),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    controller.breedingTransactionModel.placeMeeting,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 77, 82, 105),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: controller
                        .breedingTransactionModel.paymentForMalePetOwnerTime !=
                    null,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      height: 1,
                      color: DARK_GREY_COLOR.withAlpha(50),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.breedingTransactionModel
                                      .ownerPetFemaleId ==
                                  controller.accountModel.customerModel.id
                              ? 'Payment time'
                              : 'Buyer payment time',
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 77, 82, 105),
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          controller.breedingTransactionModel
                                      .paymentForMalePetOwnerTime !=
                                  null
                              ? FORMAT_DATE_TIME(
                                  dateTime: controller.breedingTransactionModel
                                      .paymentForMalePetOwnerTime!,
                                  pattern: DATE_PATTERN_2)
                              : 'N/A',
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 77, 82, 105),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.breedingTransactionModel
                                      .ownerPetFemaleId ==
                                  controller.accountModel.customerModel.id
                              ? 'Payment method'
                              : 'Buyer payment method',
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 77, 82, 105),
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          controller.breedingTransactionModel.paymentMethod ??
                              'N/A',
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 77, 82, 105),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              controller.breedingTransactionModel.star != null &&
                      controller.breedingTransactionModel.star != 0 &&
                      controller.accountModel.customerModel.id !=
                          controller.breedingTransactionModel.ownerPetFemaleId
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Buyer rating star for you',
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 77, 82, 105),
                            letterSpacing: 0.5,
                          ),
                        ),
                        ratingBarWidget(
                            star: controller.breedingTransactionModel.star!
                                .toDouble()),
                      ],
                    )
                  : const SizedBox.shrink(),
              controller.breedingTransactionModel.review != null &&
                      controller.breedingTransactionModel.review!.isNotEmpty &&
                      controller.accountModel.customerModel.id !=
                          controller.breedingTransactionModel.ownerPetFemaleId
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            'Buyer review',
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 77, 82, 105),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            controller.breedingTransactionModel.review!,
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                              letterSpacing: 0.5,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        Container(
          height: 1,
          color: LIGHT_GREY_COLOR.withAlpha(30),
        ),
        Container(
          color: const Color.fromARGB(255, 245, 248, 253),
          height: 16,
        ),
      ],
    );
  }

  Widget ratingBarWidget({required double star}) => RatingBar.builder(
        initialRating: star,
        itemCount: 5,
        itemSize: 20,
        allowHalfRating: false,
        unratedColor: Colors.amber.withOpacity(0.2),
        itemBuilder: (context, index) => const Icon(
          Icons.star_rate_rounded,
          color: Color.fromARGB(255, 255, 211, 78),
        ),
        onRatingUpdate: (_) {},
        ignoreGestures: true,
      );

  Widget rhombusItemListWidget({required double screenWidth}) {
    List<Widget> listRhombus = [rhombusItemWidget()];
    int numberOfRhombus = screenWidth ~/ 8;

    do {
      numberOfRhombus--;
      listRhombus.add(rhombusItemWidget());
    } while (numberOfRhombus > 0);

    return Positioned(
      bottom: 10,
      child: Row(
        children: listRhombus,
      ),
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
                color: const Color.fromARGB(255, 245, 248, 253),
              ),
            ),
          ),
        ],
      );
}
