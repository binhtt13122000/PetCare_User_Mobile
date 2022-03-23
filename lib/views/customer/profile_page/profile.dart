import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';

class ProfilePage extends GetView {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(children: [
                const Text(
                  'Profile Page',
                  style: TextStyle(fontSize: 40),
                ),
                InkWell(
                  child: const Text(
                    'Pet Manager',
                    style: TextStyle(fontSize: 40),
                  ),
                  onTap: () => Get.toNamed(PET_MANAGEMENT_PAGE_ROUNTER),
                ),
                InkWell(
                  child: const Text(
                    'Log out',
                    style: TextStyle(fontSize: 40),
                  ),
                  onTap: () => Get.toNamed(LANDING_PAGE_ROUNTER),
                ),
              ]),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavigatorBar(),
            ),
          ],
        ),
      ),
    );
  }
}