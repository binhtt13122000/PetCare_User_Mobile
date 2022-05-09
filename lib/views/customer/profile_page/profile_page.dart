import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';
import 'package:petapp_mobile/views/customer/profile_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/profile_page/widgets/top_widget.dart';

class ProfilePage extends GetView {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInPageController signInPageController =
        Get.find<SignInPageController>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Stack(
          children: [
            Column(
              children: [
                ProfilePageTopWidget(
                    accountModel: signInPageController.accountModel!),
                Expanded(
                  child: SingleChildScrollView(
                    child: ProfilePageBodyWidget(
                        accountModel: signInPageController.accountModel!),
                  ),
                ),
                // InkWell(
                //   child: const Text(
                //     'Pet Manager',
                //     style: TextStyle(fontSize: 40),
                //   ),
                //   onTap: () => Get.toNamed(PET_MANAGEMENT_PAGE_ROUNTER),
                // ),
                // InkWell(
                //   child: const Text(
                //     'Log out',
                //     style: TextStyle(fontSize: 40),
                //   ),
                //   onTap: () => Get.toNamed(LANDING_PAGE_ROUNTER),
                // ),
              ],
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