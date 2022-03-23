import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        ICON_PATH + PET_LOGO_SVG,
                        color: PRIMARY_COLOR,
                        height: 29,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        'iU Petshop',
                        style: GoogleFonts.satisfy(
                          textStyle: const TextStyle(color: PRIMARY_COLOR),
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          height: 1,
                        ),
                      ),
                    ],
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
                      style: GoogleFonts.itim(
                        color: WHITE_COLOR,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              IMAGE_PATH + DOG_CARTOON_PNG,
              height: 300,
            ),
            Text(
              'Welcom to iU Petshop!',
              style: GoogleFonts.itim(
                color: PRIMARY_COLOR,
                fontSize: 27,
              ),
            ),
            Text(
              'This place provide all the pet services you need.',
              style: GoogleFonts.itim(
                color: LIGHT_GREY_COLOR,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: 30,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                Container(
                  height: 5,
                  width: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 234, 217, 235),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                Container(
                  height: 5,
                  width: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 234, 217, 235),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: MaterialButton(
                      color: PRIMARY_COLOR,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign In with Phone Number',
                            style: GoogleFonts.quicksand(
                              color: WHITE_COLOR,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => Get.toNamed(SIGN_IN_PAGE_ROUNTER),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.black26,
                        height: 0.5,
                        width: 110,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          'or',
                          style: GoogleFonts.itim(
                            color: PRIMARY_COLOR,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black26,
                        height: 0.5,
                        width: 110,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: MaterialButton(
                      color: PRIMARY_LIGHT_COLOR,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You are new? Register now',
                            style: GoogleFonts.quicksand(
                              color: PRIMARY_COLOR,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: 'By sign in or register, you agree to ',
                        style: GoogleFonts.quicksand(
                          color: DARK_GREY_COLOR,
                          fontSize: 13,
                        ),
                        children: const [
                          TextSpan(
                            text: 'the Terms of Service',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
