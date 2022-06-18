import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SignInTopWidget extends GetView<SignInPageController> {
  const SignInTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => topTitleWidget();

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get..back(),
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
                      'iU PetShop',
                      style: GoogleFonts.satisfy(
                        textStyle: const TextStyle(color: PRIMARY_COLOR),
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        height: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
