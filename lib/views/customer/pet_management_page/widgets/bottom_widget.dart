import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';

class PetsManagementBottomWidget extends GetView<PetManagementPageController> {
  const PetsManagementBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(height: 1, color: DARK_GREY_COLOR.withOpacity(0.1)),
          createPostButtonWidget(),
          // managementHistoryButtonWidget(),
        ],
      );

  Widget createPostButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          onTap: () {
            Get.toNamed(CREATE_PET_PAGE_ROUNTER);
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 192, 195, 207),
              ),
              borderRadius: BorderRadius.circular(3),
              color: const Color.fromARGB(255, 243, 243, 243),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create A New Pet',
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 64, 69, 87),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  ICON_PATH + ADD_SVG,
                  color: const Color.fromARGB(255, 64, 69, 87),
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      );

  Widget managementHistoryButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: InkWell(
          onTap: () => controller.update(),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 192, 195, 207),
              ),
              borderRadius: BorderRadius.circular(3),
              color: const Color.fromARGB(255, 243, 243, 243),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Management History',
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 64, 69, 87),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  ICON_PATH + HISTORY_SVG,
                  color: const Color.fromARGB(255, 64, 69, 87),
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      );
}
