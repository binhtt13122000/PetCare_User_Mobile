import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_list_page_controller.dart';
import 'package:petapp_mobile/models/chat_room_model/chat_room_model.dart';
import 'package:petapp_mobile/services/chat_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class ChattingListBodyWidget extends GetView<ChattingListPageController> {
  const ChattingListBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChattingListPageController>(builder: (_) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
        controller.isLoadingRoom.value = true;
        controller.chatRoomList =
            await ChatServices.fetchChatRoomListByCustomerId(
                customerId: controller.accountModel.customerModel.id);
        controller.isLoadingRoom.value = false;
      });
      return Obx(() {
        return controller.isLoadingRoom.value
            ? const Expanded(
                child: Center(
                  child: SpinKitSpinningLines(
                    color: PRIMARY_COLOR,
                    size: 100,
                  ),
                ),
              )
            : listMessageRoom();
      });
    });
  }

  Widget listMessageRoom() => GetBuilder<ChattingListPageController>(
        builder: (_) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: controller.chatRoomList
                    .asMap()
                    .entries
                    .map(
                      (e) => chatCardWidget(chatRoomModel: e.value),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      );

  Widget chatCardWidget({required ChatRoomModel chatRoomModel}) => Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: InkWell(
          onTap: () async {
            Get.toNamed(
                '$CHATTING_DETAIL_PAGE_ROUTE/chatRoomId/${chatRoomModel.id}');
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Stack(
                  children: [
                    CircleAvatar(
                      minRadius: 22,
                      maxRadius: 22,
                      backgroundImage: NetworkImage(
                          controller.accountModel.customerModel.avatar),
                    ),
                    Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.bottomRight,
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 211, 227, 253),
                        maxRadius: 9,
                        minRadius: 9,
                        child: CircleAvatar(
                          backgroundColor: WHITE_COLOR,
                          maxRadius: 8,
                          minRadius: 8,
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 141, 238, 233),
                            maxRadius: 6,
                            minRadius: 6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Chatbox for post #0${chatRoomModel.postId}',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: GoogleFonts.quicksand(
                                  color: const Color.fromARGB(255, 62, 68, 87),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              FORMAT_DATE_TIME(
                                dateTime: chatRoomModel.newestMessageTime,
                                pattern: TIME_PATTERN,
                              ),
                              textAlign: TextAlign.start,
                              style: GoogleFonts.quicksand(
                                color: const Color.fromARGB(255, 99, 108, 136),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        chatRoomModel.newestMessage,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 135, 145, 175),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 22,
                  color: Color.fromARGB(255, 154, 163, 192),
                ),
              ),
            ],
          ),
        ),
      );
}
