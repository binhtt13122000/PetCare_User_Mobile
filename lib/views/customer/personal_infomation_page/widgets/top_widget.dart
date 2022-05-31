import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/personal_information_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PersonalInformationTopWidget
    extends GetView<PersonalInfomationPageController> {
  const PersonalInformationTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            topTitleWidget(),
            avatarWidget(),
          ],
        ),
      );

  Widget avatarWidget() => Stack(
        children: [
          GRADIENT_WIDGET(
            child: const CircleAvatar(
              maxRadius: 50,
              minRadius: 50,
            ),
          ),
          CircleAvatar(
            maxRadius: 50,
            minRadius: 50,
            backgroundColor: Colors.transparent,
            child: controller.accountModel.customerModel.avatar!.isEmpty
                ? CircleAvatar(
                    backgroundColor: PRIMARY_COLOR.withOpacity(0.7),
                    maxRadius: 46,
                    minRadius: 46,
                    child: Text(
                      controller.accountModel.customerModel.avatarCharacter,
                      style: GoogleFonts.quicksand(
                        color: WHITE_COLOR,
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : CircleAvatar(
                    maxRadius: 46,
                    minRadius: 46,
                    backgroundImage: NetworkImage(
                        controller.accountModel.customerModel.avatar!),
                  ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(210, 193, 204, 233),
              child: Icon(
                Icons.camera_alt,
                color: Color.fromARGB(255, 127, 137, 163),
                size: 23,
              ),
            ),
          ),
        ],
      );

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: DARK_GREY_COLOR.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Color.fromARGB(255, 61, 78, 100),
                  size: 18,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  'Personal Information',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 62, 68, 87),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
