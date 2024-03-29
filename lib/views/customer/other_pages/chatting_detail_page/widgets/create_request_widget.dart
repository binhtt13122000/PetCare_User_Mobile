import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/other_pages/chatting_detail_page/widgets/pet_drop_down_list_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/chatting_detail_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreateRequestWidget extends GetView<ChattingDetailPageController> {
  const CreateRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(() {
        return controller.isShowCreateRequest.value
            ? GetBuilder<ChattingDetailPageController>(builder: (_) {
                if (controller.chatRoomModel!.type == 'BREED') {
                  controller.isShowLoadingPet.value = true;

                  WidgetsBinding.instance!.addPostFrameCallback((_) async {
                    controller
                      ..pets = await PetService.fetchPetListToCreatePost(
                          jwt: controller.accountModel.jwtToken,
                          customerId: controller.accountModel.customerModel.id,
                          type: controller.chatRoomModel!.type,
                          speciesId: controller
                              .postModel.petModel!.breedModel!.speciesId,
                          breedId: controller.postModel.petModel!.breedId,
                          gender: 'FEMALE')
                      ..selectedPetIndex.value =
                          controller.pets.isNotEmpty ? 0 : -1
                      ..isShowLoadingPet.value = false;
                  });
                }
                double widgetHeight =
                    controller.chatRoomModel!.status == 'REQUESTED' ? 520 : 470;
                widgetHeight +=
                    controller.chatRoomModel!.type == 'BREED' ? 100 : 0;
                return Obx(
                  () => controller.isShowLoadingPet.value
                      ? InkWell(
                          onTap: () =>
                              controller.isShowCreateRequest.value = false,
                          child: Container(
                            color: const Color.fromARGB(106, 188, 196, 201),
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  width: 300,
                                  height: widgetHeight,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: LOADING_WIDGET()),
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            InkWell(
                              onTap: () =>
                                  controller.isShowCreateRequest.value = false,
                              child: Container(
                                color: const Color.fromARGB(106, 188, 196, 201),
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 300,
                                    height: widgetHeight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: WHITE_COLOR,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Create Transaction Request',
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
                                            ownerAddress: controller
                                                .accountModel
                                                .customerModel
                                                .address!),
                                        controller.chatRoomModel!.type ==
                                                'BREED'
                                            ? const ChattingDetailSelectPetWidget()
                                            : const SizedBox.shrink(),
                                        descriptionWidget(),
                                        sendRequestWidget(),
                                        cancelRequestWidget(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const ChattingDetailPetDropdownListWidget(),
                          ],
                        ),
                );
              })
            : const SizedBox.shrink();
      });

  Widget sendRequestWidget() => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: InkWell(
          onTap: () {
            if (controller.transactionTimeText.value.isNotEmpty &&
                controller.transactionLocation.value.isNotEmpty &&
                (controller.chatRoomModel!.type == 'BREED'
                    ? controller.selectedPetIndex.value != -1
                    : true)) {
              controller.isShowCreateRequest.value = false;
              String message = 'Transaction request - status: ' +
                  (controller.chatRoomModel!.status == 'REQUESTED'
                      ? '[UPDATED]'
                      : '[CREATED]') +
                  '. Transaction place: ${controller.transactionLocation.value}. Transaction date: ${FORMAT_DATE_TIME(dateTime: controller.transactionTime!, pattern: DATE_PATTERN)}. ' +
                  controller.description.value;
              controller.chatRoomModel!
                ..transactionPlace = controller.transactionLocation.value
                ..transactionTime = controller.transactionTime
                ..description = controller.description.value
                ..status = 'REQUESTED'
                ..isSellerMessage = false
                ..newestMessage = message
                ..newestMessageTime = DateTime.now();

              Map<String, dynamic> emitJsonMap =
                  controller.chatRoomModel!.toJson();

              emitJsonMap.addAll({
                'message': message,
              });
              if (controller.chatRoomModel!.type == 'BREED') {
                emitJsonMap.addAll({
                  'petId':
                      controller.pets[controller.selectedPetIndex.value].id,
                });
              }
              controller.socket.emit(
                'updateRoom',
                emitJsonMap,
              );
            }
          },
          child: Obx(
            () => Container(
              height: 35,
              decoration: BoxDecoration(
                color: controller.transactionTimeText.value.isNotEmpty &&
                        controller.transactionLocation.value.isNotEmpty &&
                        (controller.chatRoomModel!.type == 'BREED'
                            ? controller.selectedPetIndex.value != -1
                            : true)
                    ? PRIMARY_COLOR.withOpacity(0.9)
                    : PRIMARY_COLOR.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: DARK_GREY_COLOR.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: GetBuilder<ChattingDetailPageController>(
                builder: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.chatRoomModel!.status == 'REQUESTED'
                          ? 'Update request'
                          : 'Send request to seller',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.quicksand(
                        color: WHITE_COLOR,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    Visibility(
                      visible: controller.chatRoomModel!.status == 'CREATED',
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: SvgPicture.asset(
                          ICON_PATH + SEND_SVG,
                          height: 18,
                          color: WHITE_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget cancelRequestWidget() => Visibility(
        visible: controller.chatRoomModel!.status == 'REQUESTED',
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: () {
              controller.isShowCreateRequest.value = false;
              String message = 'Transaction request - status: [CANCELED].';
              controller.chatRoomModel!
                ..status = 'CREATED'
                ..isSellerMessage = false
                ..newestMessage = message
                ..newestMessageTime = DateTime.now();

              Map<String, dynamic> emitJsonMap =
                  controller.chatRoomModel!.toJson();

              emitJsonMap.addAll({'message': message});
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
                      'Cancel request',
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
                  Text(
                    '*',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 241, 99, 88),
                      fontSize: 20,
                      height: 0.8,
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
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(right: 5),
                      child: Checkbox(
                        value: controller.isUseOwnerAddress.value,
                        onChanged: (isCheck) {
                          controller.isUseOwnerAddress.value = isCheck!;
                          if (isCheck) {
                            controller.transactionLocationTextEditingController
                                .text = ownerAddress;
                            controller.transactionLocation.value = ownerAddress;
                          }
                        },
                        activeColor: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                  Text(
                    'Use owner address',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 85, 103, 128),
                      fontSize: 13,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      minLines: 3,
                      maxLines: 3,
                      maxLength: 40,
                      controller:
                          controller.transactionLocationTextEditingController,
                      onChanged: (String text) {
                        controller.transactionLocation.value = text;
                      },
                      keyboardType: TextInputType.multiline,
                      cursorColor: PRIMARY_COLOR,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 113, 135, 168),
                        fontSize: 15,
                        letterSpacing: 1,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type transaction location here...',
                        hintStyle: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 162, 176, 194),
                          fontSize: 13,
                          letterSpacing: 1,
                        ),
                        border: InputBorder.none,
                        counterText: '',
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  minLines: 3,
                  maxLines: 3,
                  controller: controller.descriptionTextEditingController,
                  onChanged: (String text) {
                    controller.description.value = text;
                  },
                  keyboardType: TextInputType.multiline,
                  cursorColor: PRIMARY_COLOR,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 113, 135, 168),
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'More information about the transaction...',
                    hintStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 162, 176, 194),
                      fontSize: 13,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
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
                    Text(
                      '*',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w800,
                        color: const Color.fromARGB(255, 241, 99, 88),
                        fontSize: 20,
                        height: 0.8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => controller.isShowCalendar.value = true,
            child: Container(
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
                    child: Obx(
                      () => controller.transactionTimeText.value.isEmpty
                          ? Text(
                              'dd/MM/yyyy',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 162, 176, 194),
                                fontSize: 13,
                                letterSpacing: 1,
                              ),
                            )
                          : Text(
                              controller.transactionTimeText.value,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 113, 135, 168),
                                fontSize: 15,
                                letterSpacing: 1,
                              ),
                            ),
                    ),
                  ),
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: PRIMARY_COLOR,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
