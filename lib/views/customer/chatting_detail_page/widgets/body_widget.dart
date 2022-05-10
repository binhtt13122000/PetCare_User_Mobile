import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class ChattingDetailBodyWidget extends GetView<ChattingPageController> {
  const ChattingDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ownerChatCardWidget(
                chatContent:
                    ' dog of mastiff type. It may also be known as the English Bulldog or British Bulldog. It is of medium size, a muscular, hefty dog with a wrinkled face and a distinctive pushed-in nose.',
              ),
              ownerChatCardWidget(
                  chatContent: 'British breed of dosh', isLastChat: true),
              otherChatCardWidget(
                  chatContent: '12345678901234567', isLastChat: true),
              ownerChatCardWidget(
                chatContent:
                    'The Bul of doh Bulldog. Iinkled face and a distinctive pushed-in nose.',
                isLastChat: true,
              ),
              otherChatCardWidget(chatContent: 'chatContent'),
              otherChatCardWidget(
                  chatContent:
                      '1234567890' '1234567890' '1234567899 afd aeo 23423 ads'),
              otherChatCardWidget(
                  chatContent:
                      'The Bulldog is a British brze, a muscular, hefty dog with a wrinkled face and a distinctive pushed-in nose.',
                  isLastChat: true),
              ownerChatCardWidget(chatContent: '12345667899 afd aeo 23423 ads'),
              ownerChatCardWidget(
                chatContent:
                    'h e known as the English Bullmuscular, hefty dog with a wrinkled face and a distinctive pushed-in nose.',
                isLastChat: true,
              ),
              otherChatCardWidget(
                  chatContent:
                      'as the English Bullmuscular, hefty dog with a wrinkled face'),
              otherChatCardWidget(
                  chatContent: 'aaag is a British breed of dosh',
                  isLastChat: true),
              ownerChatCardWidget(
                  chatContent:
                      '1234567890' '1234567890' '1234567899 afd aeo 23423 ads',
                  isLastChat: true),
            ],
          ),
        ),
      );

  Widget ownerChatCardWidget(
          {required String chatContent, bool isLastChat = false}) =>
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
                    Container(
                      width: chatContent.length >= 35 ? 260 : null,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: PRIMARY_COLOR,
                      ),
                      child: Text(
                        chatContent,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.quicksand(
                          color: WHITE_COLOR,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
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
                            dateTime: DateTime.now(),
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
          {required String chatContent, bool isLastChat = false}) =>
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
                      ? const CircleAvatar(
                          maxRadius: 14,
                          minRadius: 14,
                          backgroundImage:
                              AssetImage(IMAGE_PATH + GUEST_AVATAR_PNG),
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
                        Container(
                          width: chatContent.length >= 35 ? 260 : null,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 220, 224, 238),
                          ),
                          child: Text(
                            chatContent,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.quicksand(
                              color: const Color.fromARGB(255, 76, 85, 117),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
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
                            dateTime: DateTime.now(),
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
