import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/models/messasge_model.dart/message_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class ChattingDetailBodyWidget extends GetView<ChattingDetailPageController> {
  const ChattingDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Obx(
            () => Visibility(
              visible: controller.isLoadingMoreChat.value,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: const SpinKitSpinningLines(
                  color: PRIMARY_COLOR,
                  size: 40,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: GetBuilder<ChattingDetailPageController>(
                builder: (controller) {
                  controller.currentMaxScrollPosition =
                      controller.currentMaxScrollPosition == -1
                          ? 0
                          : controller
                              .scrollController.position.maxScrollExtent;

                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    if (controller.isLoadingMoreChat.value) {
                      controller.isLoadingMoreChat.value = false;
                      print(controller.scrollController.position.maxScrollExtent
                              .toString() +
                          '---' +
                          controller.currentMaxScrollPosition.toString());

                      if (controller
                              .scrollController.position.maxScrollExtent !=
                          controller.currentMaxScrollPosition) {
                        controller.scrollController.jumpTo(controller
                                .scrollController.position.maxScrollExtent -
                            controller.currentMaxScrollPosition -
                            70);
                      }
                    } else {
                      controller.scrollController.animateTo(
                          controller.scrollController.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.ease);
                    }
                  });
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:
                        controller.messageModelList.asMap().entries.map((e) {
                      print(e.value.isSellerMessage);
                      print(controller.accountModel.id ==
                          controller.postModel.customerId);

                      return e.value.isSellerMessage ==
                              (controller.accountModel.customerModel.id ==
                                  controller.postModel.customerId)
                          ? ownerChatCardWidget(messageModel: e.value)
                          : otherChatCardWidget(messageModel: e.value);
                    }).toList(),
                  );
                },
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
                                messageModel.content.length >= 35 ? 260 : null,
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
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              isLastChat
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12, top: 2),
                      child: Text(
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
                      ? CircleAvatar(
                          maxRadius: 14,
                          minRadius: 14,
                          backgroundImage: NetworkImage(
                              controller.anotherChatRoomMember.avatar),
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
                                width: messageModel.content.length >= 35
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
                      child: Text(
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
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      );
}
