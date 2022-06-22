import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class AppLogoPage extends GetView {
  const AppLogoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(IMAGE_PATH + FONDOS_BACKGROUND_PNG),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GRADIENT_WIDGET(
                  child: SvgPicture.asset(
                    ICON_PATH + PET_LOGO_SVG,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    allowDrawingOutsideViewBox: true,
                  ),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 90, 253, 253),
                    Color.fromARGB(255, 190, 152, 252),
                  ]),
                ),
                const SizedBox(
                  width: 2,
                ),
                GRADIENT_WIDGET(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      'iU PetShop ',
                      style: GoogleFonts.satisfy(
                        textStyle: const TextStyle(color: WHITE_COLOR),
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                        height: 1.2,
                      ),
                    ),
                  ),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 181, 138, 250),
                    Color.fromARGB(255, 1, 226, 226),
                  ]),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'We know how to care for the paw that held\nyour hand when you needed a shoulder',
              textAlign: TextAlign.center,
              style: GoogleFonts.satisfy(
                textStyle: TextStyle(color: WHITE_COLOR.withOpacity(0.9)),
                fontWeight: FontWeight.w700,
                fontSize: 17,
                height: 1.2,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
