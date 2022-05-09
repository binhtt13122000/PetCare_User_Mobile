import 'package:flutter/material.dart';
import 'package:petapp_mobile/views/guest/landing_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/guest/landing_page/widgets/top_widget.dart';

class GuestLandingPage extends StatelessWidget {
  const GuestLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 251, 255),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            GuestLandingTopWidget(),
            GuestLandingBodyWidget(),
          ],
        ),
      );
}
