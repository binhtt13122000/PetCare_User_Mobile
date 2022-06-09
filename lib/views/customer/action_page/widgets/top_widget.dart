import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/action_page_controller.dart';

class ActionTopWidget extends GetView<ActionPageController> {
  const ActionTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          topTitleWidget(),
          searchWidget(),
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
                  'Actions Page',
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

  Widget searchWidget() => Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 12),
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
                  hintText: 'Search for action',
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
