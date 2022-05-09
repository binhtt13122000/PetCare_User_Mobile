import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class GuestLandingTopWidget extends GetView {
  const GuestLandingTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GRADIENT_WIDGET(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      ICON_PATH + PET_LOGO_SVG,
                      color: PRIMARY_COLOR,
                      height: 29,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      'iU Petshop',
                      style: GoogleFonts.satisfy(
                        textStyle: const TextStyle(color: PRIMARY_COLOR),
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: PRIMARY_COLOR,
                shape: BoxShape.circle,
              ),
              child: Text(
                'Vi',
                style: GoogleFonts.quicksand(
                  color: WHITE_COLOR,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );
}
