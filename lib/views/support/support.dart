import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';

class Support extends GetView {
  const Support({Key? key}) : super(key: key);

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
                  'Support Page',
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
