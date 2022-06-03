import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/models/message_model.dart/message_model.dart';
import 'package:petapp_mobile/services/chat_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ChattingDetailBottomWidget extends GetView<ChattingDetailPageController> {
  const ChattingDetailBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      GetBuilder<ChattingDetailPageController>(
        builder: (_) => controller.chatRoomModel == null ||
                controller.chatRoomModel!.status == 'CREATED' ||
                controller.chatRoomModel!.status == 'REQUESTED'
            ? Column(
                children: [
                  Container(
                    height: 1,
                    margin: const EdgeInsets.only(top: 5),
                    color: const Color.fromARGB(255, 151, 163, 179),
                  ),
                  chatBoxWidget(),
                ],
              )
            : CUSTOM_TEXT('Chat is over'),
      );

  Widget mediaItemWidget({required index, required File mediaFile}) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.file(
                mediaFile,
                height: 70,
                width: 65,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: InkWell(
              onTap: () => controller
                ..mediaList.removeAt(index)
                ..update(),
              child: CircleAvatar(
                minRadius: 15,
                maxRadius: 15,
                backgroundColor: WHITE_COLOR.withOpacity(0.9),
                child: SvgPicture.asset(
                  ICON_PATH + CLOSE_SVG,
                  color: Colors.red,
                  height: 15,
                ),
              ),
            ),
          )
        ],
      );

  Widget chatBoxWidget() {
    TextEditingController _textEditingController = TextEditingController();
    return GetBuilder<ChattingDetailPageController>(
      builder: (_) => Container(
        height: controller.mediaList.isNotEmpty ? 80 : 40,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: InkWell(
                onTap: () async {
                  File? mediaFile = await PICK_IMAGE(isPickFromGalley: false);
                  if (mediaFile != null) {
                    controller.mediaList.add(mediaFile);

                    controller.update();
                  }
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: DARK_GREY_COLOR.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    ICON_PATH + CAMERA_SVG,
                    height: 20,
                    color: const Color.fromARGB(255, 78, 98, 124),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: InkWell(
                onTap: () async {
                  List<File>? mediaFiles = await PICK_IMAGE_LIST();
                  if (mediaFiles != null) {
                    for (var element in mediaFiles) {
                      controller.mediaList.add(element);
                    }
                    controller.update();
                  }
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: DARK_GREY_COLOR.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    ICON_PATH + GALLERY_SVG,
                    height: 20,
                    color: const Color.fromARGB(255, 78, 98, 124),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 167, 181, 201),
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => controller.chatTextValue.value.isEmpty &&
                              controller.mediaList.isEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SvgPicture.asset(
                                ICON_PATH + MESSENGER_SVG,
                                height: 20,
                                color: const Color.fromARGB(255, 162, 176, 194),
                              ),
                            )
                          : const SizedBox(width: 5),
                    ),
                    Expanded(
                      child: controller.mediaList.isNotEmpty
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: controller.mediaList
                                    .asMap()
                                    .entries
                                    .map((e) => mediaItemWidget(
                                        index: e.key, mediaFile: e.value))
                                    .toList(),
                              ),
                            )
                          : TextField(
                              controller: _textEditingController,
                              onChanged: (String text) {
                                controller.chatTextValue.value = text;
                              },
                              keyboardType: TextInputType.multiline,
                              cursorColor: PRIMARY_COLOR,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 113, 135, 168),
                                fontSize: 15,
                              ),
                              decoration: InputDecoration.collapsed(
                                hintText: 'Type your chat here...',
                                hintStyle: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 162, 176, 194),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.chatTextValue.value.isEmpty &&
                      controller.mediaList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: PRIMARY_COLOR),
                            boxShadow: [
                              BoxShadow(
                                color: DARK_GREY_COLOR.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.emoji_emotions,
                            color: PRIMARY_COLOR,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: InkWell(
                        onTap: () async {
                          if (controller.mediaList.isNotEmpty) {
                            for (var element in controller.mediaList) {
                              String? tmpUrl = await ChatServices.uploadMedia(
                                  mediaFilePath: element.path);
                              if (tmpUrl != null) {
                                if (controller.chatRoomModel != null) {
                                  MessageModel messageModel = MessageModel(
                                    isSellerMessage: controller
                                            .accountModel.customerModel.id ==
                                        controller.postModel.customerId,
                                    content: tmpUrl,
                                    type: 'IMAGE',
                                    createdTime: DateTime.now(),
                                    buyerId: controller
                                        .accountModel.customerModel.id,
                                    postId: controller.postModel.id,
                                    sellerId: controller.postModel.customerId,
                                    room: controller.chatRoomModel!.id,
                                  );
                                  controller.socket
                                      .emit('chatToServer', messageModel);
                                } else {
                                  Map<String, dynamic> emitDataJson =
                                      MessageModel(
                                    isSellerMessage: controller
                                            .accountModel.customerModel.id ==
                                        controller.postModel.customerId,
                                    content: tmpUrl,
                                    type: 'IMAGE',
                                    createdTime: DateTime.now(),
                                    buyerId: controller
                                        .accountModel.customerModel.id,
                                    postId: controller.postModel.id,
                                    sellerId: controller.postModel.customerId,
                                    room: null,
                                  ).toJson();
                                  emitDataJson.addAll(
                                      {'roomType': controller.postModel.type});
                                  controller.socket
                                      .emit('chatToServer', emitDataJson);
                                }

                                controller.update();
                              }
                            }
                            controller.mediaList = [];
                            controller.update();
                          } else {
                            if (controller.chatRoomModel != null) {
                              MessageModel messageModel = MessageModel(
                                isSellerMessage:
                                    controller.accountModel.customerModel.id ==
                                        controller.postModel.customerId,
                                content: controller.chatTextValue.value,
                                type: 'NORMAL',
                                createdTime: DateTime.now(),
                                buyerId:
                                    controller.accountModel.customerModel.id,
                                postId: controller.postModel.id,
                                sellerId: controller.postModel.customerId,
                                room: controller.chatRoomModel!.id,
                              );
                              controller.socket
                                  .emit('chatToServer', messageModel);
                            } else {
                              Map<String, dynamic> emitDataJson = MessageModel(
                                isSellerMessage:
                                    controller.accountModel.customerModel.id ==
                                        controller.postModel.customerId,
                                content: controller.chatTextValue.value,
                                type: 'NORMAL',
                                createdTime: DateTime.now(),
                                buyerId:
                                    controller.accountModel.customerModel.id,
                                postId: controller.postModel.id,
                                sellerId: controller.postModel.customerId,
                                room: null,
                              ).toJson();
                              emitDataJson.addAll(
                                  {'roomType': controller.postModel.type});
                              controller.socket
                                  .emit('chatToServer', emitDataJson);
                            }

                            controller.chatTextValue.value = '';
                            _textEditingController.clear();
                          }
                        },
                        child: SvgPicture.asset(
                          ICON_PATH + SEND_SVG,
                          height: 25,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
