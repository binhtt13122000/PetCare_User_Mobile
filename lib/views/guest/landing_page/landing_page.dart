import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/guest/landing_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/guest/landing_page/widgets/top_widget.dart';

class GuestLandingPage extends GetView {
  const GuestLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            GuestLandingTopWidget(),
            GuestLandingBodyWidget(),
          ],
        ),
      );
}
