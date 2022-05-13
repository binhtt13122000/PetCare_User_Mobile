import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_page_controller.dart';
import 'package:petapp_mobile/models/chat_model/chat_model.dart';

class ChattingDetailBottomWidget extends GetView<ChattingPageController> {
  const ChattingDetailBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 5),
            color: const Color.fromARGB(255, 151, 163, 179),
          ),
          chatBoxWidget(),
        ],
      );

  Widget chatBoxWidget() {
    TextEditingController _textEditingController = TextEditingController();
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: InkWell(
              onTap: () => Get.back(),
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
              onTap: () => Get.back(),
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
                    () => controller.chatTextValue.value.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SvgPicture.asset(
                              ICON_PATH + MESSENGER_SVG,
                              height: 20,
                              color: const Color.fromARGB(255, 162, 176, 194),
                            ),
                          )
                        : const SizedBox(width: 5),
                  ),
                  Expanded(
                    child: TextField(
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
                          color: const Color.fromARGB(255, 162, 176, 194),
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
            () => controller.chatTextValue.value.isEmpty
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
                      onTap: () {
                        controller.chatModelsList.add(
                          ChatModel(
                            isOwnerChat: true,
                            isLastChat: true,
                            chatContent: controller.chatTextValue.value,
                            chatTime: DateTime.now(),
                          ),
                        );
                        controller.chatTextValue.value = '';
                        _textEditingController.clear();
                        controller.update();
                        controller.scrollController.animateTo(
                            controller
                                .scrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.ease);
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
    );
  }
}
