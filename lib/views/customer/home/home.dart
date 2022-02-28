import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_controller.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';
import 'package:petapp_mobile/views/customer/home/widgets/pet_services.dart';
import 'package:petapp_mobile/views/customer/home/widgets/purchase_card.dart';
import 'package:petapp_mobile/views/customer/home/widgets/top_navigation_bar.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                //!Top navigation
                const SizedBox(
                  height: 135,
                  child: TopNavigationBar(),
                ),
                //!Pet services
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pet Services',
                        style: GoogleFonts.itim(
                          textStyle: const TextStyle(color: DARK_GREY_COLOR),
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'See All',
                        style: GoogleFonts.itim(
                          textStyle: const TextStyle(color: LIGHT_GREY_COLOR),
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const PetService(),
                //!Purchase Cart
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suggestions For You',
                        style: GoogleFonts.itim(
                          textStyle: const TextStyle(color: DARK_GREY_COLOR),
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'See All',
                        style: GoogleFonts.itim(
                          textStyle: const TextStyle(color: LIGHT_GREY_COLOR),
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Expanded(
                    child: Visibility(
                      visible: controller.selectedServiceIndex.value == 1,
                      child: Column(
                        children: const [
                          Expanded(child: PurchaseCard()),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => controller.selectedServiceIndex.value == 2
                      ? Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Veterinary',
                                style: GoogleFonts.itim(fontSize: 35),
                              )
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => controller.selectedServiceIndex.value == 3
                      ? Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Grooming',
                                style: GoogleFonts.itim(fontSize: 35),
                              )
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => controller.selectedServiceIndex.value == 4
                      ? Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Breeding',
                                style: GoogleFonts.itim(fontSize: 35),
                              )
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => controller.selectedServiceIndex.value == 5
                      ? Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Training',
                                style: GoogleFonts.itim(fontSize: 35),
                              )
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
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
