import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/customer/action_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';

class AcctionPage extends GetView {
  const AcctionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const AcctionTopWidget(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Image.asset(
                                        IMAGE_PATH + BACKGROUND_ONE_PNG),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: const EdgeInsets.only(top: 270),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            color: Color.fromARGB(
                                                255, 234, 217, 235),
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
                                            color: Color.fromARGB(
                                                255, 234, 217, 235),
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
                                onPressed: () =>
                                    Get.toNamed(POST_MANAGEMENT_PAGE_ROUNTER),
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
                                    Get.toNamed(PET_MANAGEMENT_PAGE_ROUTE),
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
                                    Get.toNamed(TRANSACTION_PAGE_ROUTE),
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
                                height: 15,
                              ),
                              MaterialButton(
                                height: 50,
                                minWidth: 500,
                                onPressed: () => Get.toNamed(
                                    TRANSACTION_AT_CENTER_DETAIL_PAGE_ROUTE),
                                color: PRIMARY_LIGHT_COLOR,
                                child: Text(
                                  'Test order',
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
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigatorBar(),
          )
        ],
      ),
    );
  }
}
