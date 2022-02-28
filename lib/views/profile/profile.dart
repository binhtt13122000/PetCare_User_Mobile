import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';

class Profile extends GetView {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(children: const [
                Text(
                  'Profile Page',
                  style: TextStyle(fontSize: 40),
                ),
              ]),
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
