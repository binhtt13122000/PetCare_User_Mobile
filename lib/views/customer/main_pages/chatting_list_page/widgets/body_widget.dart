import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/chatting_list_page_controller.dart';
import 'package:petapp_mobile/models/chat_room_model/chat_room_model.dart';
import 'package:petapp_mobile/services/other_services/chat_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ChattingListBodyWidget extends GetView<ChattingListPageController> {
  const ChattingListBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          viewTypeWidget(),
          GetBuilder<ChattingListPageController>(builder: (_) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
              controller.isLoadingRoom.value = true;
              controller.chatRoomList =
                  await ChatServices.fetchChatRoomListByCustomerId(
                      customerId: controller.accountModel.customerModel.id,
                      roomType:
                          controller.selectedChatRoomType.value == 'Opened Room'
                              ? 'open'
                              : 'close');
              controller.isLoadingRoom.value = false;
            });
            return Obx(
              () => controller.isLoadingRoom.value
                  ? const Expanded(
                      child: Center(
                        child: SpinKitSpinningLines(
                          color: PRIMARY_COLOR,
                          size: 100,
                        ),
                      ),
                    )
                  : listMessageRoom(),
            );
          }),
        ],
      ),
    );
  }

  Widget viewTypeWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.chatRoomTypes
            .asMap()
            .entries
            .map((e) => viewTypeItemWidget(viewType: e.value))
            .toList(),
      );

  Widget viewTypeItemWidget({required String viewType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () {
              controller
                ..selectedChatRoomType.value = viewType
                ..update();
            },
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedChatRoomType.value == viewType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          maxRadius: 3,
                          backgroundColor:
                              controller.selectedChatRoomType.value == viewType
                                  ? PRIMARY_COLOR
                                  : Colors.transparent,
                        ),
                      ),
                      Text(
                        viewType,
                        style: GoogleFonts.quicksand(
                          color:
                              controller.selectedChatRoomType.value == viewType
                                  ? PRIMARY_COLOR
                                  : const Color.fromARGB(255, 116, 122, 143),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  color: controller.selectedChatRoomType.value == viewType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );

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
            Get.toNamed('$CHATTING_DETAIL_PAGE_ROUTE/${chatRoomModel.id}');
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
                          controller.accountModel.customerModel.avatar!),
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
                              child: Row(
                                children: [
                                  CUSTOM_TEXT('[${chatRoomModel.type}]',
                                      padding: const EdgeInsets.only(right: 5),
                                      color: chatRoomModel.type == 'SALE'
                                          ? BLUE_COLOR
                                          : PINK_COLOR),
                                  Text(
                                    'Chatroom #0${chatRoomModel.postId}',
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: GoogleFonts.quicksand(
                                      color:
                                          const Color.fromARGB(255, 62, 68, 87),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
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
                      Row(
                        children: [
                          Text(
                            chatRoomModel.isSellerMessage &&
                                    (chatRoomModel.sellerId ==
                                        controller
                                            .accountModel.customerModel.id)
                                ? 'You: '
                                : 'Other: ',
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
                          Expanded(
                            child: Text(
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
                          ),
                        ],
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
