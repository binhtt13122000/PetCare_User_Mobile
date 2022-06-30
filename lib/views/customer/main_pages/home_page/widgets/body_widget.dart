import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/home_page_controller.dart';
import 'package:petapp_mobile/views/customer/main_pages/home_page/widgets/center_widget.dart';
import 'package:petapp_mobile/views/customer/main_pages/home_page/widgets/post_gird_widget.dart';
import 'package:petapp_mobile/views/customer/main_pages/home_page/widgets/services_list_widget.dart';

class HomeBodyWidget extends GetView<HomePageController> {
  const HomeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Widget bodyWidget;
      switch (controller.selectedServiceIndex.value) {
        case 1:
          bodyWidget = const HomePostGirdsWidget();
          break;
        case 2:
          bodyWidget = const HomeCenterWidget();
          break;
        case 3:
          bodyWidget = const HomeServicesListWidget();
          break;
        case 4:
          bodyWidget = breedServicesWidget();
          break;
        case 5:
          bodyWidget = trainingServicesWidget();
          break;
        default:
          bodyWidget = const HomePostGirdsWidget();
      }
      return Column(
        children: [
          Container(
            color: DARK_GREY_COLOR.withOpacity(0.2),
            height: 1,
            margin: const EdgeInsets.only(
              right: 20,
              left: 20,
              bottom: 10,
            ),
          ),
          bodyWidget,
          const SizedBox(
            height: 60,
          ),
        ],
      );
    });
  }

  Widget veterinaryServicesWidget() => Expanded(
        child: Column(
          children: [
            Text(
              'Veterinary',
              style: GoogleFonts.itim(fontSize: 35),
            )
          ],
        ),
      );

  Widget groomingServicesWidget() => Expanded(
        child: Column(
          children: [
            Text(
              'Grooming',
              style: GoogleFonts.itim(fontSize: 35),
            )
          ],
        ),
      );

  Widget breedServicesWidget() => Expanded(
        child: Column(
          children: [
            Text(
              'Breeding',
              style: GoogleFonts.itim(fontSize: 35),
            )
          ],
        ),
      );

  Widget trainingServicesWidget() => Expanded(
        child: Column(
          children: [
            Text(
              'Training',
              style: GoogleFonts.itim(fontSize: 35),
            )
          ],
        ),
      );
}
