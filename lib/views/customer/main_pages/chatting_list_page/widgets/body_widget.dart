import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/chatting_list_page_controller.dart';
import 'package:petapp_mobile/models/chat_room_model/chat_room_model.dart';
import 'package:petapp_mobile/services/other_services/chat_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                  ? Expanded(child: LOADING_WIDGET(size: 100))
                  : Expanded(
                      child: SmartRefresher(
                        controller: RefreshController(),
                        onRefresh: () => controller.update(),
                        child: SingleChildScrollView(
                          child: controller.chatRoomList.isEmpty
                              ? Padding(
                                  child: NO_DATA_WIDGET(
                                      content: 'Sorry, no chat room found.'),
                                  padding: const EdgeInsets.only(top: 150),
                                )
                              : listMessageRoom(),
                        ),
                      ),
                    ),
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
        builder: (_) => Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 50),
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
                padding: const EdgeInsets.only(left: 0),
                child: Stack(
                  children: [
                    GRADIENT_WIDGET(
                      child: const CircleAvatar(
                        radius: 22,
                      ),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.transparent,
                      child: chatRoomModel.customerModel!.avatar != null
                          ? CircleAvatar(
                              radius: 19,
                              backgroundImage: NetworkImage(
                                  chatRoomModel.customerModel!.avatar!),
                            )
                          : CircleAvatar(
                              radius: 19,
                              backgroundColor: WHITE_COLOR,
                              child: CUSTOM_TEXT(
                                chatRoomModel.customerModel!.avatarCharacter,
                                fontWeight: FontWeight.w700,
                                color: PRIMARY_COLOR,
                                fontSize: 18,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CUSTOM_TEXT('[${chatRoomModel.type}]',
                              padding: const EdgeInsets.only(right: 5),
                              color: chatRoomModel.type == 'SALE'
                                  ? BLUE_COLOR
                                  : PINK_COLOR),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '#0${chatRoomModel.postId} - ${chatRoomModel.customerModel!.firstName} ${chatRoomModel.customerModel!.lastName}',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: GoogleFonts.quicksand(
                                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
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
                                : '${chatRoomModel.customerModel!.lastName}: ',
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
                            child: CUSTOM_TEXT(
                              chatRoomModel.newestMessage
                                      .startsWith('https://firebasestorage')
                                  ? 'was sent a media.'
                                  : chatRoomModel.newestMessage,
                              textAlign: TextAlign.start,
                              textOverflow: TextOverflow.ellipsis,
                              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
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
                    ],
                  ),
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 10),
              //   child: Icon(
              //     Icons.check_circle_outline,
              //     size: 22,
              //     color: Color.fromARGB(255, 154, 163, 192),
              //   ),
              // ),
            ],
          ),
        ),
      );
}
