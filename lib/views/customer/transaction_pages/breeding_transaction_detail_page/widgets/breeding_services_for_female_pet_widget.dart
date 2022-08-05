import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/services/transaction_services/order_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionDetailBreedingServicesForFemalePetWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailBreedingServicesForFemalePetWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      GetBuilder<BreedingTransactionDetailPageController>(builder: (_) {
        controller.isWaitingLoadingDataInBreedingTab.value = true;

        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller.orderId ??=
              await OrderServices.fetchOrderByBreedingTransactionId(
                  jwt: controller.accountModel.jwtToken,
                  breedingTransactionId: controller.breedingTransactionId);
          if (controller.orderId != null) {
            controller.orderModel = await OrderServices.fetchOrderIdByOrderId(
                jwt: controller.accountModel.jwtToken,
                orderId: controller.orderId!);
          }
          controller
            ..breedingTransactionModel =
                await BreedingTransactionService.fetchBreedingTransactionById(
                    jwt: controller.accountModel.jwtToken,
                    breedingTransactionId: controller.breedingTransactionId)
            ..sortComboList()
            ..isWaitingLoadingDataInBreedingTab.value = false
            ..isShowBottomWidget.value = true;
        });
        return Obx(
          () => controller.isWaitingLoadingDataInBreedingTab.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: LOADING_WIDGET(size: 90),
                )
              : Column(
                  children: [
                    controller.breedingTransactionModel.dateOfBreeding ==
                                null ||
                            [
                              'CANCELED',
                              'BREEDING_CANCELED',
                              'EXPIRED',
                              'CREATED'
                            ].contains(
                                controller.breedingTransactionModel.status)
                        ? noHaveDataWidget()
                        : breedingServicesWidget(),
                  ],
                ),
        );
      });

  Widget buyBreedingServicesCombo() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CUSTOM_TEXT(
                    'To take good care of your pet during the breeding period, you can buy more service combos with many attractive incentives',
                    fontSize: 14,
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    textOverflow: TextOverflow.clip,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () => Get.toNamed(
                  '$BUY_BREEDING_SERVICES_COMBO_PAGE_ROUTE/${controller.breedingTransactionId}'),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CUSTOM_TEXT(
                  'Go to buy services combo page',
                  color: WHITE_COLOR,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );

  Widget noHaveDataWidget() {
    late String content;
    switch (controller.breedingTransactionModel.status) {
      case 'CREATED':
        content = 'Use our reproductive health\n services, booking one now!';
        break;
      case 'CANCELED':
        content =
            'This breeding transaction have been canceled, you can buy more breeding services!';
        break;
      case 'EXPIRED':
        content =
            'This breeding transaction have been expired, you can buy more breeding services!';
        break;
      default:
        content =
            'This breeding transaction have been completed, you can buy more breeding services!';
    }
    return Container(
      color: WHITE_COLOR,
      padding: EdgeInsets.symmetric(
          vertical: controller.breedingTransactionModel.status == 'CREATED'
              ? 120
              : 170),
      child: Center(
        child: Column(children: [
          CUSTOM_TEXT(
            content,
            textOverflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            fontSize: 14,
            padding: const EdgeInsets.symmetric(horizontal: 35),
          ),
          Visibility(
            visible: controller.breedingTransactionModel.status == 'CREATED',
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () => Get.toNamed(
                    '$CREATE_TICKET_PAGE_ROUTE?breedingTransactionId=${controller.breedingTransactionId}'),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CUSTOM_TEXT('Go to booking page',
                      letterSpacing: 1, color: WHITE_COLOR),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ]),
      ),
    );
  }

  Widget breedingServicesWidget() => Column(
        children: [
          breedingServicesTimeLineWidget(),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 16,
            color: SUPPER_LIGHT_BLUE.withAlpha(30),
          ),
          Visibility(
            visible: controller.breedingTransactionModel.isSuccess != null &&
                controller.breedingTransactionModel.isSuccess! &&
                (controller.breedingTransactionModel.petComboModelList ==
                        null ||
                    controller
                        .breedingTransactionModel.petComboModelList!.isEmpty),
            child: Column(
              children: [
                buyBreedingServicesCombo(),
                Container(
                  height: 1,
                  color: LIGHT_GREY_COLOR.withAlpha(30),
                ),
                Container(
                  height: 16,
                  color: SUPPER_LIGHT_BLUE.withAlpha(30),
                ),
              ],
            ),
          ),
          branchWidget(),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 16,
            color: SUPPER_LIGHT_BLUE.withAlpha(30),
          ),
        ],
      );

  Widget branchWidget() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            CUSTOM_TEXT(
              'Branch perform services',
              padding: const EdgeInsets.only(bottom: 10),
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            textCardWidget(
                keyText: 'Name',
                valueText: controller
                    .breedingTransactionModel.breedingBranchModel!.name),
            textCardWidget(
                keyText: 'Phone number',
                valueText: controller
                    .breedingTransactionModel.breedingBranchModel!.phoneNumber),
            textCardWidget(
                keyText: 'Address',
                valueText: controller.breedingTransactionModel
                        .breedingBranchModel!.address ??
                    'N/A'),
          ],
        ),
      );

  Widget textCardWidget({required String keyText, required String valueText}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CUSTOM_TEXT(
              keyText,
              fontSize: 15,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
              padding: const EdgeInsets.only(right: 20),
            ),
            Expanded(
              child: CUSTOM_TEXT(valueText,
                  fontSize: 15,
                  textAlign: TextAlign.end,
                  textOverflow: TextOverflow.clip),
            ),
          ],
        ),
      );

  Widget breedingServicesTimeLineWidget() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            CUSTOM_TEXT(
              'Breeding services timeline',
              padding: const EdgeInsets.only(bottom: 20),
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            timeLineWidget(),
          ],
        ),
      );

  Widget timeLineWidget() {
    switch (controller.breedingTransactionModel.status) {
      case 'BREEDING_REQUESTED':
        return breedingRequestTimelineItemWidget();
      case 'IN_PROGRESS':
        return breedingInProgressTimelineItemWidget();
      case 'BREEDING_FINISHED':
        return breedingFinishedTimelineItemWidget();
      case 'BREEDING_SUCCESS':
        return controller.breedingTransactionModel.isSuccess == null
            ? breedingSuccessTimelineItemWidget()
            : ultrasoundTimelineItemWidget();
      default:
        return breedingRequestTimelineItemWidget();
    }
  }

  Widget comboServicesTimelineWidget({bool isUltrasound = true}) {
    DateTime currentTime = DateTime.now();

    return Column(
      children: controller.breedingTransactionModel.petComboModelList![0]
          .petComboDetailModelList!
          .asMap()
          .entries
          .map((e) {
        if (isUltrasound) {
          bool isNext = false;
          if (e.key == 0) {
            isNext = !e.value.isCompleted;
          } else {
            isNext = !e.value.isCompleted &&
                controller.breedingTransactionModel.petComboModelList![0]
                    .petComboDetailModelList![e.key - 1].isCompleted;
          }

          return timeLineItemWidget(
            currentTime: currentTime,
            title: e.value.centerServiceModel.name,
            performDate: e.value.realTime,
            estimateDate: e.value.workingTime,
            isSuccess: e.value.realTime != null,
            isShowViewDetail: e.value.isCompleted,
            onTap: e.value.isCompleted
                ? () {
                    controller
                      ..detailPopupEvidence = e.value.evidence!
                      ..detailPopupTitle = e.value.centerServiceModel.name
                      ..isShowDetailPopup.value = true;
                  }
                : null,
            isLastIndex: e.key + 1 ==
                controller.breedingTransactionModel.petComboModelList![0]
                    .petComboDetailModelList!.length,
            isNext: isNext,
          );
        } else {
          return timeLineItemWidget(
            currentTime: currentTime,
            title: e.value.centerServiceModel.name,
            performDate: e.value.realTime,
            estimateDate: e.value.workingTime,
            isSuccess: false,
            isShowViewDetail: false,
            isLastIndex: e.key ==
                controller.breedingTransactionModel.petComboModelList![0]
                    .petComboDetailModelList!.length,
            isNext: false,
          );
        }
      }).toList(),
    );
  }

  Widget comboServicesLineWidget({bool isUltrasound = true}) {
    return Column(
      children: controller.breedingTransactionModel.petComboModelList![0]
          .petComboDetailModelList!
          .asMap()
          .entries
          .map((e) {
        if (isUltrasound) {
          late String status;
          bool isBeforeItemNext = false;
          if (e.key == 0) {
            status = e.value.isCompleted ? 'SUCCESS' : 'NEXT';
          } else {
            if (e.value.isCompleted) {
              status = 'SUCCESS';
            } else {
              if (controller.breedingTransactionModel.petComboModelList![0]
                  .petComboDetailModelList![e.key - 1].isCompleted) {
                status = 'NEXT';
              } else {
                status = 'WAITING';
                if (e.key == 1) {
                  isBeforeItemNext = true;
                } else {
                  if (controller.breedingTransactionModel.petComboModelList![0]
                      .petComboDetailModelList![e.key - 2].isCompleted) {
                    isBeforeItemNext = true;
                  }
                }
              }
            }
          }
          return lineWidget(status: status, isBeforeItemNext: isBeforeItemNext);
        } else {
          return lineWidget(status: 'WAITING', isBeforeItemNext: e.key == 0);
        }
      }).toList(),
    );
  }

  Widget ultrasoundTimelineItemWidget() {
    DateTime currentTime = DateTime.now();
    return Stack(
      children: [
        Column(
          children: [
            timeLineItemWidget(
              currentTime: currentTime,
              isSuccess: true,
              title: 'Branch receive pets and conduct breeding',
              dateTitle: 'Start breeding on ',
              performDate: controller.breedingTransactionModel.dateOfBreeding,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Breeding finished',
              isSuccess: true,
              dateTitle: 'Breeding finished on ',
              performDate: controller.breedingTransactionModel.dateOfFinish,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Pickup pet and payment',
              dateTitle: 'Payment on ',
              performDate: controller.orderModel!.paymentTime,
              isSuccess: true,
              isShowViewDetail: true,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: '1st ultrasound',
              performDate:
                  controller.breedingTransactionModel.timeToCheckBreeding!,
              isSuccess: true,
              hintText: controller.breedingTransactionModel.isSuccess!
                  ? 'Your pet is pregnant'
                  : 'Your pet is not pregnant',
              isShowViewDetail: true,
              onTap: () => controller
                ..detailPopupEvidence =
                    controller.breedingTransactionModel.evidence
                ..detailPopupTitle = '1st Ultrasound Evidences'
                ..isShowDetailPopup.value = true,
              hintTextColor: controller.breedingTransactionModel.isSuccess!
                  ? BLUE_COLOR
                  : RED_COLOR,
              isLastIndex:
                  controller.breedingTransactionModel.petComboModelList ==
                          null ||
                      controller
                          .breedingTransactionModel.petComboModelList!.isEmpty,
            ),
            controller.breedingTransactionModel.petComboModelList != null &&
                    controller
                        .breedingTransactionModel.petComboModelList!.isNotEmpty
                ? comboServicesTimelineWidget()
                : const SizedBox.shrink(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 136),
          child: Column(
            children: [
              lineWidget(status: 'SUCCESS'),
              lineWidget(status: 'SUCCESS'),
              lineWidget(status: 'SUCCESS'),
              controller.breedingTransactionModel.petComboModelList != null &&
                      controller.breedingTransactionModel.petComboModelList!
                          .isNotEmpty
                  ? comboServicesLineWidget()
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  Widget breedingSuccessTimelineItemWidget() {
    DateTime currentTime = DateTime.now();
    return Stack(
      children: [
        Column(
          children: [
            timeLineItemWidget(
              currentTime: currentTime,
              isSuccess: true,
              title: 'Branch receive pets and conduct breeding',
              dateTitle: 'Start breeding on ',
              performDate: controller.breedingTransactionModel.dateOfBreeding,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Breeding finished',
              isSuccess: true,
              dateTitle: 'Breeding finished on ',
              performDate: controller.breedingTransactionModel.dateOfFinish,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Pickup pet and payment',
              dateTitle: 'Payment on ',
              performDate: controller.orderModel!.paymentTime,
              isSuccess: true,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: '1st ultrasound',
              estimateDate:
                  controller.breedingTransactionModel.timeToCheckBreeding!,
              isNext: true,
              isLastIndex: true,
            ),
            controller.breedingTransactionModel.petComboModelList != null &&
                    controller
                        .breedingTransactionModel.petComboModelList!.isNotEmpty
                ? Column(
                    children: [
                      const SizedBox(
                        height: 31,
                      ),
                      comboServicesTimelineWidget(isUltrasound: false),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 136),
          child: Column(
            children: [
              lineWidget(status: 'SUCCESS'),
              lineWidget(status: 'SUCCESS'),
              lineWidget(status: 'NEXT'),
              controller.breedingTransactionModel.petComboModelList != null &&
                      controller.breedingTransactionModel.petComboModelList!
                          .isNotEmpty
                  ? comboServicesLineWidget(isUltrasound: false)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  Widget breedingFinishedTimelineItemWidget() {
    DateTime currentTime = DateTime.now();
    return Stack(
      children: [
        Column(
          children: [
            timeLineItemWidget(
              currentTime: currentTime,
              isSuccess: true,
              title: 'Branch receive pets and conduct breeding',
              dateTitle: 'Start breeding on ',
              performDate: controller.breedingTransactionModel.dateOfBreeding,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Breeding finished',
              isSuccess: true,
              dateTitle: 'Breeding finished on ',
              performDate: controller.breedingTransactionModel.dateOfFinish,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Pickup pet and payment',
              isShowTime: false,
              cardTimeText: 'Available',
              hintText: 'Available for pickup pet and payment',
              isNext: true,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: '1st ultrasound',
              estimateDate:
                  controller.breedingTransactionModel.timeToCheckBreeding!,
              isLastIndex: true,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 136),
          child: Column(
            children: [
              lineWidget(status: 'SUCCESS'),
              lineWidget(status: 'NEXT'),
              lineWidget(status: 'WAITING', isBeforeItemNext: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget breedingPaymentTimelineItemWidget() {
    DateTime currentTime = DateTime.now();
    return Stack(
      children: [
        Column(
          children: [
            timeLineItemWidget(
              currentTime: currentTime,
              isSuccess: true,
              title: 'Branch receive pets to conduct breeding',
              dateTitle: 'Start breeding on ',
              estimateDate: DateTime.now(),
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Breeding finished',
              isSuccess: true,
              estimateDate:
                  controller.breedingTransactionModel.dateOfBreeding!.add(
                const Duration(
                  days: 3,
                ),
              ),
              dateTitle: 'Breeding finished on ',
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: '1st ultrasound',
              estimateDate:
                  controller.breedingTransactionModel.dateOfBreeding!.add(
                const Duration(
                  days: 17,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 136),
          child: Column(
            children: [
              lineWidget(status: 'SUCCESS'),
              lineWidget(status: 'NEXT'),
            ],
          ),
        ),
      ],
    );
  }

  Widget breedingInProgressTimelineItemWidget() {
    DateTime currentTime = DateTime.now();
    return Stack(
      children: [
        Column(
          children: [
            timeLineItemWidget(
              currentTime: currentTime,
              isSuccess: true,
              title: 'Branch receive pets and conduct breeding',
              dateTitle: 'Start breeding on ',
              performDate: controller.breedingTransactionModel.dateOfBreeding,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Breeding finished',
              estimateDate:
                  controller.breedingTransactionModel.dateOfBreeding!.add(
                const Duration(
                  days: 3,
                ),
              ),
              dateTitle: 'Estimate finished on ',
              isNext: true,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Pickup pet and payment',
              isShowTime: false,
              cardTimeText: 'Not applicable',
              hintText: 'Waiting for breeding finished',
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: '1st ultrasound',
              estimateDate:
                  controller.breedingTransactionModel.dateOfBreeding!.add(
                const Duration(days: 30),
              ),
              isLastIndex: true,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 136),
          child: Column(
            children: [
              lineWidget(status: 'NEXT'),
              lineWidget(
                status: 'WAITING',
                isBeforeItemNext: true,
              ),
              lineWidget(status: 'WAITING'),
            ],
          ),
        ),
      ],
    );
  }

  Widget breedingRequestTimelineItemWidget() {
    DateTime currentTime = DateTime.now();
    return Stack(
      children: [
        Column(
          children: [
            timeLineItemWidget(
              currentTime: currentTime,
              isSuccess: false,
              title: 'Branch receive pets and conduct breeding',
              dateTitle: 'Appointment date ',
              estimateDate: controller.breedingTransactionModel.dateOfBreeding,
              isNext: true,
            ),
            timeLineItemWidget(
              currentTime: currentTime,
              title: 'Breeding finished',
              estimateDate:
                  controller.breedingTransactionModel.dateOfBreeding!.add(
                const Duration(
                  days: 3,
                ),
              ),
              dateTitle: 'Estimate finished on ',
            ),
            timeLineItemWidget(
                currentTime: currentTime,
                title: 'Pickup pet and payment',
                isShowTime: false,
                cardTimeText: 'Not applicable',
                hintText: 'Waiting for breeding finished'),
            timeLineItemWidget(
              currentTime: currentTime,
              title: '1st ultrasound',
              estimateDate:
                  controller.breedingTransactionModel.dateOfBreeding!.add(
                const Duration(
                  days: 33,
                ),
              ),
              isLastIndex: true,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 136),
          child: Column(
            children: [
              lineWidget(status: 'WAITING', isBeforeItemNext: true),
              lineWidget(status: 'WAITING'),
              lineWidget(status: 'WAITING'),
            ],
          ),
        ),
      ],
    );
  }

  Widget timeLineItemWidget({
    required DateTime currentTime,
    bool isSuccess = false,
    bool isLastIndex = false,
    required String title,
    DateTime? estimateDate,
    DateTime? performDate,
    String? dateTitle,
    bool isShowTime = true,
    String? cardTimeText,
    String? hintText,
    bool isNext = false,
    bool isShowViewDetail = false,
    Color? hintTextColor,
    Function()? onTap,
  }) {
    late int durationDays;
    String prefixDurationText = '';
    String suffixDurationText = '';
    String durationUnit = '';

    if (cardTimeText == null) {
      if (isSuccess) {
        durationDays = (performDate!.difference(currentTime).inHours ~/ 24);
      } else {
        durationDays = (estimateDate!.difference(currentTime).inHours ~/ 24);
      }
      if (durationDays >= 365) {
        int durationUnitNum = (durationDays / 365).ceil();
        if (durationUnitNum < 183) {
          durationUnitNum--;
        }
        durationUnit = durationUnitNum.toString();
        suffixDurationText = ' years';
      } else if (durationDays >= 30) {
        prefixDurationText = 'Next ';
        int durationUnitNum = (durationDays / 30).ceil();
        if (durationUnitNum < 15) {
          durationUnitNum--;
        }
        durationUnit = durationUnitNum.toString();
        suffixDurationText = ' months';
      } else if (durationDays > 0) {
        prefixDurationText = 'Next ';
        durationUnit = (durationDays).toString();
        suffixDurationText = ' days';
      }
      //!future
      else if (durationDays == 0) {
        durationUnit = 'Today';
      }
      //!past
      else if (durationDays <= -365) {
        prefixDurationText = 'Next ';

        int durationUnitNum = (durationDays / -365).ceil();
        if (durationUnitNum < 183) {
          durationUnitNum--;
        }
        durationUnit = durationUnitNum.toString();
        suffixDurationText = ' years ago';
      } else if (durationDays <= -30) {
        int durationUnitNum = (durationDays / -30).ceil();
        if (durationUnitNum < 15) {
          durationUnitNum--;
        }
        durationUnit = durationUnitNum.toString();
        suffixDurationText = ' months ago';
      } else {
        durationUnit = (durationDays * -1).toString();
        suffixDurationText = ' days ago';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 25,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    isSuccess ? PRIMARY_COLOR : PRIMARY_COLOR.withOpacity(0.4),
                border: Border.all(
                    color: isNext ? PRIMARY_COLOR : Colors.transparent)),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: cardTimeText != null
                  ? CUSTOM_TEXT(
                      cardTimeText,
                      textAlign: TextAlign.center,
                      color: WHITE_COLOR,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    )
                  : Row(
                      children: [
                        CUSTOM_TEXT(
                          prefixDurationText,
                          textAlign: TextAlign.center,
                          color: WHITE_COLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                        CUSTOM_TEXT(
                          durationUnit,
                          textAlign: TextAlign.center,
                          color: WHITE_COLOR,
                          fontSize: 11,
                        ),
                        CUSTOM_TEXT(
                          suffixDurationText,
                          textAlign: TextAlign.center,
                          color: WHITE_COLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ],
                    ),
            ),
          ),
          Column(
            children: [
              // Visibility(
              //   visible: !isSuccess,
              //   child: const SizedBox(
              //     height: 3,
              //     width: 2,
              //   ),
              // ),
              isSuccess
                  ? Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: const CircleAvatar(
                        backgroundColor: PRIMARY_COLOR,
                        minRadius: 12,
                        maxRadius: 12,
                        child: CircleAvatar(
                          backgroundColor: WHITE_COLOR,
                          minRadius: 10,
                          maxRadius: 10,
                          child: CircleAvatar(
                            backgroundColor: PRIMARY_COLOR,
                            minRadius: 8,
                            maxRadius: 8,
                            child: Icon(
                              Icons.done,
                              size: 14,
                              color: WHITE_COLOR,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: PRIMARY_COLOR,
                        minRadius: isNext ? 11 : 10,
                        maxRadius: isNext ? 11 : 10,
                        child: CircleAvatar(
                          backgroundColor: WHITE_COLOR,
                          minRadius: 10,
                          maxRadius: 10,
                          child: CircleAvatar(
                            backgroundColor: PRIMARY_COLOR.withOpacity(0.3),
                            minRadius: 10,
                            maxRadius: 10,
                            child: const Icon(
                              Icons.remove_circle_outline,
                              size: 18,
                              color: WHITE_COLOR,
                            ),
                          ),
                        ),
                      ),
                    ),
              Visibility(
                visible: !isLastIndex,
                child: SizedBox(
                  height: isSuccess ? 95 : 75,
                  width: 2,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CUSTOM_TEXT(title,
                            textOverflow: TextOverflow.clip,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isSuccess || isNext
                                ? DARK_GREY_TEXT_COLOR.withOpacity(0.9)
                                : DARK_GREY_TEXT_COLOR.withOpacity(0.7)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CUSTOM_TEXT('Status: ',
                          fontSize: 13,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.85)),
                      CUSTOM_TEXT(isSuccess ? 'Successfully' : 'Waiting',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isSuccess ? GREEN_COLOR : YELLOW_COLOR),
                    ],
                  ),
                  const SizedBox(height: 0),
                  isShowTime
                      ? CUSTOM_TEXT(
                          (dateTitle ??
                                  (isSuccess
                                      ? 'Perform on '
                                      : 'Estimated perform on ')) +
                              FORMAT_DATE_TIME(
                                  dateTime:
                                      isSuccess ? performDate! : estimateDate!,
                                  pattern: DATE_PATTERN_2),
                          fontSize: 13,
                          color: isSuccess || isNext
                              ? DARK_GREY_TEXT_COLOR.withOpacity(0.85)
                              : DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                          textOverflow: TextOverflow.clip,
                        )
                      : const SizedBox.shrink(),
                  hintText != null
                      ? CUSTOM_TEXT(
                          hintText,
                          fontSize: 13,
                          color: hintTextColor ??
                              DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                          textOverflow: TextOverflow.clip,
                          fontWeight: hintTextColor != null
                              ? FontWeight.w700
                              : FontWeight.w500,
                        )
                      : const SizedBox.shrink(),
                  Visibility(
                    visible: isShowViewDetail,
                    child: viewDetailWidget(onTap: onTap),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lineWidget({
    required String status,
    bool isBeforeItemNext = false,
  }) {
    double height = 85;
    Color color = LIGHT_GREY_COLOR.withOpacity(0.3);
    double margin = 24;
    switch (status) {
      case 'SUCCESS':
        height = 95;
        color = PRIMARY_COLOR;
        margin = 24;
        break;
      case 'NEXT':
        height = 95;
        color = PRIMARY_COLOR.withOpacity(0.5);
        margin = 24;
        break;
      case 'WAITING':
        height = 75;
        color = LIGHT_GREY_COLOR.withOpacity(0.15);
        margin = 20;
        break;
    }

    if (isBeforeItemNext) {
      margin += 2;
    }

    return status == 'NEXT'
        ? Padding(
            padding: EdgeInsets.only(top: margin),
            child: RotatedBox(
              quarterTurns: 1,
              child: SizedBox(
                height: 2,
                width: height,
                child: LinearProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation(PRIMARY_COLOR),
                  backgroundColor: LIGHT_GREY_COLOR.withOpacity(0.15),
                ),
              ),
            ),
          )
        : Container(
            width: 2,
            height: height,
            margin: EdgeInsets.only(top: margin),
            color: color,
          );
  }

  Widget viewDetailWidget({Function()? onTap}) => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View detail',
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: PRIMARY_COLOR,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.keyboard_double_arrow_right_outlined,
                    size: 14,
                    color: PRIMARY_COLOR,
                  )
                ],
              ),
              Container(
                height: 1,
                width: 95,
                color: PRIMARY_COLOR,
                margin: const EdgeInsets.only(
                  top: 2,
                ),
              ),
            ],
          ),
        ),
      );
  // Obx(
  //   () => InkWell(
  //     onTap: () => controller.showDescriptionIndexList.contains(index)
  //         ? controller.showDescriptionIndexList.remove(index)
  //         : controller.showDescriptionIndexList.add(index),
  //     child:
  //   ),
  // );
}
