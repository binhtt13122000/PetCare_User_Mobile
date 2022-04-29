import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class TopWidget extends GetView<CreatePostPageController> {
  const TopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: PRIMARY_LIGHT_COLOR,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      ICON_PATH + BACK_SVG,
                      color: PRIMARY_COLOR,
                      height: 15,
                    ),
                  ),
                ),
                GRADIENT_WIDGET(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      'Create Post',
                      style: GoogleFonts.satisfy(
                        textStyle: const TextStyle(color: PRIMARY_COLOR),
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10),
            color: LIGHT_GREY_COLOR.withOpacity(0.1),
          ),
        ],
      );
}
