import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/landing_page_controller.dart';

class GuestLandingBodyWidget extends GetView<GuestLandingPageController> {
  const GuestLandingBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            introductionWidget(),
            bottomWidget(),
          ],
        ),
      );

  Widget bottomWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 80, top: 20),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: InkWell(
                    onTap: () => Get.toNamed(SIGN_IN_PAGE_ROUTE),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In with Phone Number',
                          style: GoogleFonts.quicksand(
                            color: WHITE_COLOR,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
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
                          horizontal: 10, vertical: 5),
                      child: Text(
                        'or',
                        style: GoogleFonts.quicksand(
                          color: PRIMARY_COLOR,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
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
                Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: PRIMARY_MEDIUM_COLOR.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: InkWell(
                    onTap: () => Get.toNamed(REGISTER_PHONE_NUMBER_PAGE_ROUTE),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New to iU Petshop? Register now',
                          style: GoogleFonts.quicksand(
                            color: PRIMARY_COLOR,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller
                    ..isShowPolicy.value = true
                    ..isLoadingData.value = true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By sign in or register, you agree to ',
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 109, 119, 143),
                          fontSize: 10,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                        children: const [
                          TextSpan(
                            text: 'the Terms \nof Service',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 109, 119, 143),
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Widget introductionWidget() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              IMAGE_PATH + DOG_CARTOON_PNG,
              height: 300,
            ),
            Text(
              'Welcom to iU Petshop!',
              style: GoogleFonts.quicksand(
                color: PRIMARY_COLOR,
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'This place provide all the pet services you need.',
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 111, 121, 151),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
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
            ),
          ],
        ),
      );
}
