import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_page_controller.dart';

class ChattingDetailTopWidget extends GetView<ChattingPageController> {
  const ChattingDetailTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          topTitleWidget(),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            color: const Color.fromARGB(255, 151, 163, 179),
          ),
        ],
      );

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(100),
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
                  Icons.arrow_back_ios_new_outlined,
                  color: Color.fromARGB(255, 61, 78, 100),
                  size: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.topRight,
                    child: const CircleAvatar(
                      minRadius: 14,
                      maxRadius: 14,
                      backgroundImage:
                          AssetImage(IMAGE_PATH + GUEST_AVATAR_PNG),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.bottomLeft,
                    child: const CircleAvatar(
                      minRadius: 15,
                      maxRadius: 15,
                      backgroundColor: Color.fromARGB(255, 250, 251, 255),
                      child: CircleAvatar(
                        minRadius: 14,
                        maxRadius: 14,
                        backgroundImage:
                            AssetImage(IMAGE_PATH + GUEST_AVATAR_PNG),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'Demo chat group',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 62, 68, 87),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(100),
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
                  Icons.call,
                  color: Color.fromARGB(255, 61, 78, 100),
                  size: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: InkWell(
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  ICON_PATH + ELLIPSIS_SVG,
                  height: 15,
                  color: const Color.fromARGB(255, 61, 78, 100),
                ),
              ),
            ),
          ],
        ),
      );
}
