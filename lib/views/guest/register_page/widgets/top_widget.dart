import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/register_page_controller.dart';

class RegisterPageTopWidget extends GetView<RegisterPageController> {
  const RegisterPageTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 12),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Get.offAllNamed(LANDING_PAGE_ROUTE),
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
                      'Register Page',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        color: DARK_GREY_COLOR,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
            margin: const EdgeInsets.only(top: 10),
          ),
          Container(
            height: 20,
            color: SUPPER_LIGHT_BLUE,
          ),
        ],
      );
}
