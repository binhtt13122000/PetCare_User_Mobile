import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class ChattingLandingBodyWidget extends GetView<ChattingPageController> {
  const ChattingLandingBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                chatCardWidget(),
                chatCardWidget(),
                chatCardWidget(),
                chatCardWidget(),
                chatCardWidget(),
                chatCardWidget(),
              ],
            ),
          ),
        ),
      );

  Widget chatCardWidget() => Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: InkWell(
          onTap: () => Get.toNamed(CHATTING_DETAIL_PAGE_ROUNTER),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    child: Image.asset(IMAGE_PATH + GUEST_AVATAR_PNG),
                    maxRadius: 30,
                    minRadius: 30,
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
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
                          Text(
                            'First Last Name',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.quicksand(
                              color: const Color.fromARGB(255, 62, 68, 87),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            FORMAT_DATE_TIME(
                              dateTime: DateTime.now(),
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
                        ],
                      ),
                      Text(
                        'Current chat current chattttttttt current chat current chat',
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
