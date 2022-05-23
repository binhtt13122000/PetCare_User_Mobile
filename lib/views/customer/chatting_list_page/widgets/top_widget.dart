import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_list_page_controller.dart';

class ChattingListTopWidget extends GetView<ChattingListPageController> {
  const ChattingListTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: Column(
          children: [
            topTitleWidget(),
            searchWidget(),
          ],
        ),
      );

  Widget topTitleWidget() => Row(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 35),
              child: Text(
                'Chats',
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
        ],
      );

  Widget searchWidget() => Container(
        height: 40,
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                cursorColor: PRIMARY_COLOR,
                maxLength: 50,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 138, 154, 175),
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  prefixIcon: Align(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: SvgPicture.asset(
                      ICON_PATH + SEARCH_SVG,
                      height: 20,
                      color: const Color.fromARGB(255, 78, 98, 124),
                    ),
                  ),
                  suffixIcon: Align(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: Text(
                      '0' '/20',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 78, 98, 124),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  hintText: 'Search for chats',
                  hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 125, 141, 161),
                    fontSize: 13,
                  ),
                ),
                onChanged: (String? value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
              ),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 192, 195, 207),
                    ),
                    borderRadius: BorderRadius.circular(3),
                    color: const Color.fromARGB(255, 243, 243, 243),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Text(
                      //   '',
                      //   style: GoogleFonts.quicksand(
                      //     color: const Color.fromARGB(255, 64, 69, 87),
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      SvgPicture.asset(
                        ICON_PATH + FILTER_SVG,
                        height: 16,
                        color: const Color.fromARGB(255, 64, 69, 87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
