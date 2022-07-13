import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/services/transaction_services/sale_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyerRequestWidget extends GetView<ChattingDetailPageController> {
  const BuyerRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isShowBuyerRequest.value
          ? Stack(
              children: [
                InkWell(
                  onTap: () => controller.isShowBuyerRequest.value = false,
                  child: Container(
                    color: const Color.fromARGB(106, 198, 188, 201),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 300,
                        height: controller.chatRoomModel!.type == 'BREED'
                            ? 610
                            : 510,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: WHITE_COLOR,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GetBuilder<ChattingDetailPageController>(
                            builder: (_) {
                          if (controller.chatRoomModel!.type == 'BREED') {
                            controller.isShowLoadingPet.value = true;

                            WidgetsBinding.instance!
                                .addPostFrameCallback((_) async {
                              controller
                                ..femalePet = await PetService.fetchPetById(
                                    petId: controller.chatRoomModel!.petId!
                                        .toString())
                                ..isShowLoadingPet.value = false;
                            });
                          }

                          return Obx(
                            () => controller.isShowLoadingPet.value
                                ? LOADING_WIDGET()
                                : Column(
                                    children: [
                                      Text(
                                        'Transaction request',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.quicksand(
                                          color: PRIMARY_COLOR,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      transactionTimeWidget(),
                                      transactionLocationWidget(
                                          ownerAddress: controller.accountModel
                                              .customerModel.address!),
                                      controller.chatRoomModel!.type == 'BREED'
                                          ? buyerFemalePet()
                                          : const SizedBox.shrink(),
                                      controller.chatRoomModel!.type == 'BREED'
                                          ? petItemWidget()
                                          : const SizedBox.shrink(),
                                      descriptionWidget(),
                                      acceptBuyerRequestWidget(),
                                      denyBuyerRequestWidget(),
                                    ],
                                  ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  Widget buyerFemalePet() => Container(
        padding: const EdgeInsets.only(top: 15),
        alignment: Alignment.topLeft,
        child: Text(
          'Buyer female pet for breeding',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 78, 98, 124),
            fontSize: 16,
          ),
        ),
      );

  Widget petItemWidget() => Container(
        padding: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: PRIMARY_COLOR),
                color: PRIMARY_LIGHT_COLOR.withOpacity(0.3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9.8),
                  child: Image.network(
                    controller.femalePet.avatar,
                    height: 50,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, object, stackTrace) => Image.asset(
                      IMAGE_PATH + NO_IMAGE_PNG,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    controller.femalePet.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: PRIMARY_COLOR,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget acceptBuyerRequestWidget() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: InkWell(
          onTap: () async {
            controller
              ..isShowBuyerRequest.value = false
              ..isWaitLoadingData.value = true;
            int transactionId = controller.chatRoomModel!.type == 'SALE'
                ? await SaleTransactionService.createSaleTransaction(
                    createdTime: DateTime.now(),
                    meetingTime: controller.chatRoomModel!.transactionTime!,
                    placeMeeting: controller.chatRoomModel!.transactionPlace!,
                    sellerReceive: controller.postModel.sellerReceive,
                    transactionFee: controller.postModel.shopFee,
                    transactionTotal: controller.postModel.transactionTotal,
                    description: controller.chatRoomModel!.description,
                    buyerId: controller.chatRoomModel!.buyerId,
                    sellerId: controller.chatRoomModel!.sellerId,
                    petId: controller.postModel.petId,
                    posId: controller.chatRoomModel!.postId,
                    branchId: controller.postModel.branchId,
                    point: controller.postModel.transactionTotal ~/ 1000,
                  )
                : await BreedingTransactionService.createBreedingTransaction(
                    createdTime: DateTime.now(),
                    meetingTime: controller.chatRoomModel!.transactionTime!,
                    placeMeeting: controller.chatRoomModel!.transactionPlace!,
                    sellerReceive: controller.postModel.sellerReceive,
                    transactionFee: controller.postModel.shopFee,
                    transactionTotal: controller.postModel.transactionTotal,
                    description: controller.chatRoomModel!.description ?? '',
                    ownerPetFemaleId: controller.chatRoomModel!.buyerId,
                    ownerPetMaleId: controller.chatRoomModel!.sellerId,
                    petFemaleId: controller.chatRoomModel!.petId!,
                    petMaleId: controller.postModel.petId,
                    postId: controller.chatRoomModel!.postId,
                    branchId: controller.postModel.branchId,
                    point: controller.postModel.transactionTotal ~/ 1000,
                  );
            if (transactionId != -1) {
              String message = 'Transaction request - status: [APPROVED].';
              controller.chatRoomModel!
                ..transactionId = transactionId
                ..status = 'CREATED'
                ..isSellerMessage = true
                ..newestMessage = message
                ..newestMessageTime = DateTime.now();
              Map<String, dynamic> emitJsonMap =
                  controller.chatRoomModel!.toJson();
              emitJsonMap.addAll({'message': message});
              controller.isWaitLoadingData.value = false;
              controller.socket.emit(
                'updateRoom',
                emitJsonMap,
              );
            } else {
              controller
                ..isWaitLoadingData.value = false
                ..isShowFailedNotificationPopup.value = true;
            }
          },
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 60, 202, 190),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: const Color.fromARGB(255, 35, 170, 159),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: DARK_GREY_COLOR.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 135,
                  child: Text(
                    'Accept request',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.quicksand(
                      color: WHITE_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Icon(
                  Icons.verified,
                  size: 18,
                  color: WHITE_COLOR,
                ),
              ],
            ),
          ),
        ),
      );

  Widget transactionLocationWidget({required String ownerAddress}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: SvgPicture.asset(
                      ICON_PATH + LOCATION_SVG,
                      height: 20,
                      color: const Color.fromARGB(255, 61, 78, 100),
                    ),
                  ),
                  Text(
                    'Transaction location',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 167, 181, 201),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            controller.chatRoomModel!.transactionPlace!,
            textAlign: TextAlign.start,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 113, 135, 168),
              fontSize: 15,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget descriptionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Description',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 61, 78, 100),
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          height: 70,
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 167, 181, 201),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            controller.chatRoomModel!.description ?? '',
            textAlign: TextAlign.start,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 113, 135, 168),
              fontSize: 15,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget transactionTimeWidget() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        ICON_PATH + CLOCK_SVG,
                        height: 17,
                        color: const Color.fromARGB(255, 61, 78, 100),
                      ),
                    ),
                    Text(
                      'Transaction time',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 61, 78, 100),
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 167, 181, 201),
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    FORMAT_DATE_TIME(
                        dateTime: controller.chatRoomModel!.transactionTime!,
                        pattern: DATE_TIME_PATTERN),
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 113, 135, 168),
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_month_rounded,
                  color: Color.fromARGB(255, 113, 135, 168),
                ),
              ],
            ),
          ),
        ],
      );

  Widget denyBuyerRequestWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () async {
            controller.isShowBuyerRequest.value = false;
            controller.chatRoomModel!
              ..transactionId = null
              ..status = 'CREATED'
              ..isSellerMessage = true;
            Map<String, dynamic> emitJsonMap =
                controller.chatRoomModel!.toJson();
            emitJsonMap
                .addAll({'message': 'Transaction request - status: [DENIED].'});
            controller.socket.emit(
              'updateRoom',
              emitJsonMap,
            );
          },
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: const Color.fromARGB(255, 228, 134, 151),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: DARK_GREY_COLOR.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 135,
                  child: Text(
                    'Denine request',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 226, 66, 93),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  ICON_PATH + CLOSE_SVG,
                  height: 12,
                  color: const Color.fromARGB(255, 226, 66, 93),
                ),
              ],
            ),
          ),
        ),
      );
}
