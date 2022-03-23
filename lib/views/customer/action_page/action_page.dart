import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';

class AcctionPage extends GetView {
  const AcctionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //!app logo
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
                                textStyle:
                                    const TextStyle(color: PRIMARY_COLOR),
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 27.75,
                          width: 27,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: SvgPicture.asset(
                                  ICON_PATH + BELL_NOTIFICATION_SVG,
                                  color: PRIMARY_COLOR,
                                  height: 26,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 240, 121, 100),
                                  radius: 6.5,
                                  child: Text(
                                    '1',
                                    style: GoogleFonts.itim(
                                      fontSize: 12,
                                      color: WHITE_COLOR,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                    IMAGE_PATH + BACKGROUND_ONE_PNG),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: const EdgeInsets.only(top: 290),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 30,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 234, 217, 235),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 5,
                                      width: 15,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 234, 217, 235),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: 500,
                            onPressed: () {},
                            color: PRIMARY_LIGHT_COLOR,
                            child: Text(
                              'Post Management',
                              style: GoogleFonts.quicksand(
                                fontSize: 23,
                                color: PRIMARY_COLOR,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: 500,
                            onPressed: () =>
                                Get.toNamed(PET_MANAGEMENT_PAGE_ROUNTER),
                            color: PRIMARY_LIGHT_COLOR,
                            child: Text(
                              'Pet Mamagement',
                              style: GoogleFonts.quicksand(
                                fontSize: 23,
                                color: PRIMARY_COLOR,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: 500,
                            onPressed: () =>
                                Get.toNamed(TICKET_MANAGEMENT_PAGE_ROUNTER),
                            color: PRIMARY_LIGHT_COLOR,
                            child: Text(
                              'Ticket Management',
                              style: GoogleFonts.quicksand(
                                fontSize: 23,
                                color: PRIMARY_COLOR,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: 500,
                            onPressed: () =>
                                Get.toNamed(TRANSACTION_PAGE_ROUNTER),
                            color: PRIMARY_LIGHT_COLOR,
                            child: Text(
                              'Transaction History',
                              style: GoogleFonts.quicksand(
                                fontSize: 23,
                                color: PRIMARY_COLOR,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavigatorBar(),
            )
          ],
        ),
      ),
    );
  }
}
