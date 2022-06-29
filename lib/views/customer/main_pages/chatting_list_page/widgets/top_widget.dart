import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/chatting_list_page_controller.dart';

class ChattingListTopWidget extends GetView<ChattingListPageController> {
  const ChattingListTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          topTitleWidget(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: searchWidget(),
                ),
                const SizedBox(
                  width: 10,
                ),
                filterWidget(),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 15),
            color: LIGHT_GREY_COLOR.withOpacity(0.1),
          ),
          Container(
            height: 8,
            margin: const EdgeInsets.only(bottom: 10),
            color: const Color.fromARGB(255, 243, 248, 255),
          ),
        ],
      );

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 15),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  'Chats Page',
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
        ),
      );

  Widget filterWidget() => Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 156, 175, 202),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
            color: WHITE_COLOR),
        child: Center(
          child: SvgPicture.asset(
            ICON_PATH + FILTER_SVG,
            height: 18,
            color: const Color.fromARGB(255, 102, 116, 136),
          ),
        ),
      );

  Widget searchWidget() {
    TextEditingController textEditingController = TextEditingController();
    return Container(
      height: 35,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 162, 176, 194),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          InkWell(
            // onTap: () => controller.searchText.trim().isNotEmpty
            //     ? controller.update()
            //     : null,
            child: SvgPicture.asset(
              ICON_PATH + SEARCH_SVG,
              height: 20,
              color: const Color.fromARGB(255, 78, 98, 124),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: (String text) {
                // controller
                //   ..searchText.value = text
                //   ..offset = 0
                //   ..loadingType = LoadingType.INIT.name
                //   ..update();
              },
              keyboardType: TextInputType.text,
              maxLines: 1,
              maxLength: 20,
              cursorColor: PRIMARY_COLOR,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 113, 135, 168),
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: 'Search chat room by name...',
                hintStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 162, 176, 194),
                  fontSize: 15,
                ),
                counterText: '',
                isCollapsed: true,
                border: InputBorder.none,
              ),
            ),
          ),
          // Obx(
          //   () => Visibility(
          //     visible: controller.searchText.isNotEmpty,
          //     child: InkWell(
          //       onTap: () {
          //         textEditingController.text = '';
          //         controller
          //           ..searchText.value = ''
          //           ..offset = 0
          //           ..loadingType = LoadingType.INIT.name
          //           ..update();
          //       },
          //       child: CircleAvatar(
          //         backgroundColor: RED_COLOR.withOpacity(0.7),
          //         maxRadius: 10,
          //         child: SvgPicture.asset(
          //           ICON_PATH + CLOSE_SVG,
          //           height: 10,
          //           color: WHITE_COLOR,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget searchWidget() => Container(
  //       height: 40,
  //       margin: const EdgeInsets.symmetric(horizontal: 12),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: TextFormField(
  //               cursorColor: PRIMARY_COLOR,
  //               maxLength: 50,
  //               style: GoogleFonts.quicksand(
  //                 fontWeight: FontWeight.w500,
  //                 color: const Color.fromARGB(255, 138, 154, 175),
  //                 fontSize: 16,
  //               ),
  //               decoration: InputDecoration(
  //                 counterText: '',
  //                 prefixIcon: Align(
  //                   heightFactor: 1,
  //                   widthFactor: 1,
  //                   child: SvgPicture.asset(
  //                     ICON_PATH + SEARCH_SVG,
  //                     height: 20,
  //                     color: const Color.fromARGB(255, 78, 98, 124),
  //                   ),
  //                 ),
  //                 suffixIcon: Align(
  //                   heightFactor: 1,
  //                   widthFactor: 1,
  //                   child: Text(
  //                     '0' '/20',
  //                     style: GoogleFonts.quicksand(
  //                       fontWeight: FontWeight.w500,
  //                       color: const Color.fromARGB(255, 78, 98, 124),
  //                       fontSize: 13,
  //                     ),
  //                   ),
  //                 ),
  //                 border: const OutlineInputBorder(),
  //                 hintText: 'Search chats by room title...',
  //                 hintStyle: GoogleFonts.quicksand(
  //                   fontWeight: FontWeight.w500,
  //                   color: const Color.fromARGB(255, 125, 141, 161),
  //                   fontSize: 13,
  //                 ),
  //               ),
  //               onChanged: (String? value) {},
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //               left: 12,
  //             ),
  //             child: InkWell(
  //               onTap: () {},
  //               child: Container(
  //                 height: 40,
  //                 width: 50,
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                     color: const Color.fromARGB(255, 192, 195, 207),
  //                   ),
  //                   borderRadius: BorderRadius.circular(3),
  //                   color: const Color.fromARGB(255, 243, 243, 243),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     // Text(
  //                     //   '',
  //                     //   style: GoogleFonts.quicksand(
  //                     //     color: const Color.fromARGB(255, 64, 69, 87),
  //                     //     fontSize: 13,
  //                     //     fontWeight: FontWeight.w600,
  //                     //   ),
  //                     // ),
  //                     SvgPicture.asset(
  //                       ICON_PATH + FILTER_SVG,
  //                       height: 16,
  //                       color: const Color.fromARGB(255, 64, 69, 87),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
}
