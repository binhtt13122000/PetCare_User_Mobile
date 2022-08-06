import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/models/message_model/message_model.dart';
import 'package:petapp_mobile/services/other_services/chat_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChattingDetailBodyWidget extends GetView<ChattingDetailPageController> {
  const ChattingDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SmartRefresher(
              controller: controller.refreshController,
              scrollController: controller.scrollController,
              //  enablePullUp: true,
              onRefresh: () async {
                controller.isLoadingMoreChat = true;
                List<MessageModel> messageModelList =
                    await ChatServices.fetchMessageListByChatRoomId(
                  jwt: controller.accountModel.jwtToken,
                  chatRoomId: controller.chatRoomModel!.id,
                  limit: controller.limitMessageRange,
                  skip: controller.messageModelList.length,
                );

                messageModelList
                    .sort((a, b) => a.createdTime.compareTo(b.createdTime));
                controller
                  ..messageModelList.addAll(messageModelList)
                  ..refreshController.refreshCompleted();
              },

              child: SingleChildScrollView(
                //   controller: controller.scrollController,
                child: Obx(() {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    if (!controller.isLoadingMoreChat) {
                      controller.scrollController.animateTo(99999999,
                          duration: const Duration(seconds: 1),
                          curve: Curves.ease);
                    }
                    controller.isLoadingMoreChat = false;
                  });

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:
                        controller.messageModelList.asMap().entries.map((e) {
                      bool isLastChat = false;
                      if (e.key == 0) {
                        if (controller.messageModelList.length == 1) {
                          isLastChat = true;
                        } else if (controller
                                    .messageModelList[e.key + 1].createdTime
                                    .difference(e.value.createdTime)
                                    .inSeconds >
                                60 &&
                            controller.messageModelList[e.key + 1]
                                    .isSellerMessage !=
                                e.value.isSellerMessage) {
                          isLastChat = true;
                        }
                      } else if (e.key ==
                          controller.messageModelList.length - 1) {
                        isLastChat = true;
                      } else if (controller
                                  .messageModelList[e.key + 1].createdTime
                                  .difference(e.value.createdTime)
                                  .inSeconds >
                              60 ||
                          controller.messageModelList[e.key + 1]
                                  .isSellerMessage !=
                              e.value.isSellerMessage) {
                        isLastChat = true;
                      }

                      return e.value.isSellerMessage ==
                              (controller.accountModel.customerModel.id ==
                                  controller.postModel.customerId)
                          ? ownerChatCardWidget(
                              messageModel: e.value, isLastChat: isLastChat)
                          : otherChatCardWidget(
                              messageModel: e.value, isLastChat: isLastChat);
                    }).toList(),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ownerChatCardWidget(
          {required MessageModel messageModel, bool isLastChat = true}) =>
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.only(bottom: isLastChat ? 15 : 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 284,
                child: Row(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    messageModel.type == 'NORMAL'
                        ? Container(
                            width:
                                messageModel.content.length >= 33 ? 260 : null,
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: PRIMARY_COLOR,
                            ),
                            child: Text(
                              messageModel.content,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.quicksand(
                                color: WHITE_COLOR,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                messageModel.content,
                                height: 100,
                                errorBuilder: (_, object, stackTrace) =>
                                    Image.asset(
                                  IMAGE_PATH + NO_IMAGE_PNG,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              isLastChat
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12, top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            FORMAT_DATE_TIME(
                                dateTime: messageModel.createdTime,
                                pattern: DATE_TIME_PATTERN),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.quicksand(
                              color: const Color.fromARGB(255, 52, 58, 83),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            (controller.chatRoomModel == null ||
                                    controller.accountModel.customerModel.id ==
                                        controller.chatRoomModel!.buyerId)
                                ? ' - You (Buyer)'
                                : ' - You (Seller)',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.quicksand(
                              color: const Color.fromARGB(255, 52, 58, 83),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      );

  Widget otherChatCardWidget(
          {required MessageModel messageModel, bool isLastChat = true}) =>
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 12, bottom: isLastChat ? 15 : 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  isLastChat
                      ? controller.anotherChatRoomMember.avatar == null ||
                              controller.anotherChatRoomMember.avatar!.isEmpty
                          ? Stack(
                              children: [
                                GRADIENT_WIDGET(
                                  child: const CircleAvatar(
                                    maxRadius: 16,
                                    minRadius: 16,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  maxRadius: 16,
                                  minRadius: 16,
                                  child: CircleAvatar(
                                    maxRadius: 14,
                                    minRadius: 14,
                                    backgroundColor: WHITE_COLOR,
                                    child: Text(
                                      controller.anotherChatRoomMember
                                          .avatarCharacter,
                                      style: GoogleFonts.quicksand(
                                        color: PRIMARY_COLOR,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              children: [
                                GRADIENT_WIDGET(
                                  child: const CircleAvatar(
                                    maxRadius: 16,
                                    minRadius: 16,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  maxRadius: 16,
                                  minRadius: 16,
                                  child: CircleAvatar(
                                    maxRadius: 14,
                                    minRadius: 14,
                                    backgroundImage: NetworkImage(controller
                                        .anotherChatRoomMember.avatar!),
                                  ),
                                ),
                              ],
                            )
                      : const SizedBox(
                          width: 28,
                        ),
                  Container(
                    width: 284,
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        messageModel.type == 'NORMAL'
                            ? Container(
                                width: messageModel.content.length >= 33
                                    ? 260
                                    : null,
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(255, 220, 224, 238),
                                ),
                                child: Text(
                                  messageModel.content,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.quicksand(
                                    color:
                                        const Color.fromARGB(255, 76, 85, 117),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    messageModel.content,
                                    height: 100,
                                    errorBuilder: (_, object, stackTrace) =>
                                        Image.asset(
                                      IMAGE_PATH + NO_IMAGE_PNG,
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isLastChat
                  ? Padding(
                      padding: const EdgeInsets.only(left: 31, top: 2),
                      child: Row(
                        children: [
                          Text(
                            !(controller.chatRoomModel == null ||
                                    controller.accountModel.customerModel.id ==
                                        controller.chatRoomModel!.buyerId)
                                ? '${controller.anotherChatRoomMember.firstName} ${controller.anotherChatRoomMember.lastName} (Buyer) - '
                                : '${controller.anotherChatRoomMember.firstName} ${controller.anotherChatRoomMember.lastName} (Seller) - ',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.quicksand(
                              color: const Color.fromARGB(255, 52, 58, 83),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            FORMAT_DATE_TIME(
                                dateTime: messageModel.createdTime,
                                pattern: DATE_TIME_PATTERN),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.quicksand(
                              color: const Color.fromARGB(255, 52, 58, 83),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      );
}
