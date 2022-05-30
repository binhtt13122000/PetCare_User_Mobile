import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/profile_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ProfilePageTopWidget extends GetView<ProfilePageController> {
  const ProfilePageTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          topNavigationBarWidget(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              avatarWidget(),
              Expanded(child: generalInfoWidget()),
            ],
          ),
          viewProfileButton(),
        ],
      );

  Widget phoneNumberWidget() => InkWell(
        onTap: () {
          FirebaseAuth.instance.signOut();
          Get.deleteAll();
          Get.offAllNamed(LANDING_PAGE_ROUTE);
        },
        child: Row(
          children: [
            Text(
              controller.accountModel.hiddenPhoneNumber,
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 64, 69, 87),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color.fromARGB(255, 110, 115, 128),
                size: 23,
              ),
            )
          ],
        ),
      );

  Widget topIconWidget() => Row(
        children: [
          // InkWell(
          //   onTap: () => Get.toNamed(CHATTING_LIST_PAGE_ROUNTER),
          //   child: Container(
          //     height: 35,
          //     width: 35,
          //     decoration: BoxDecoration(
          //       color: WHITE_COLOR,
          //       borderRadius: BorderRadius.circular(10),
          //       boxShadow: [
          //         BoxShadow(
          //           color: DARK_GREY_COLOR.withOpacity(0.1),
          //           blurRadius: 5,
          //           offset: const Offset(2, 2),
          //         )
          //       ],
          //     ),
          //     child: Stack(
          //       children: [
          //         const Positioned(
          //           bottom: 5,
          //           left: 5,
          //           child: Icon(
          //             Icons.message_outlined,
          //             color: Color.fromARGB(255, 110, 117, 131),
          //             size: 22,
          //           ),
          //         ),
          //         Positioned(
          //           top: 3,
          //           right: 3,
          //           child: CircleAvatar(
          //             backgroundColor: const Color.fromARGB(255, 240, 121, 100),
          //             radius: 7,
          //             child: Text(
          //               '1',
          //               style: GoogleFonts.itim(
          //                 fontSize: 12,
          //                 color: WHITE_COLOR,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => Get.toNamed(NOTIFICATION_PAGE_ROUTE),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: DARK_GREY_COLOR.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  )
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: SvgPicture.asset(
                      ICON_PATH + BELL_SVG,
                      color: const Color.fromARGB(255, 110, 117, 131),
                      height: 25,
                    ),
                  ),
                  Positioned(
                    top: 3,
                    right: 3,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 240, 121, 100),
                      radius: 7,
                      child: Text(
                        '4',
                        style: GoogleFonts.itim(
                          fontSize: 12,
                          color: WHITE_COLOR,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget topNavigationBarWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  phoneNumberWidget(),
                  topIconWidget(),
                ],
              ),
            ),
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withOpacity(0.1),
            ),
          ],
        ),
      );

  Widget viewProfileButton() => Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: InkWell(
                onTap: () => Get.toNamed(PERSONAl_INFOMATION_PAGE_ROUTE),
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 192, 195, 207),
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'View your personal information',
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 64, 69, 87),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
            child: InkWell(
              onTap: (() {}),
              child: Container(
                height: 35,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 192, 195, 207),
                  ),
                  borderRadius: BorderRadius.circular(3),
                  color: const Color.fromARGB(255, 243, 243, 243),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Edit profile',
                      style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 64, 69, 87),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SvgPicture.asset(
                      ICON_PATH + EDITING_SVG,
                      height: 16,
                      color: const Color.fromARGB(255, 64, 69, 87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget generalInfoWidget() => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              generalInfoItemWidget(keyText: '0', valueText: 'Post'),
              generalInfoItemWidget(
                  keyText: controller.accountModel.customerModel.numberFollowers
                      .toString(),
                  valueText: 'Followers'),
              generalInfoItemWidget(keyText: '15', valueText: 'Followings'),
            ],
          ),
        ],
      );

  Widget generalInfoItemWidget(
          {required String keyText, required String valueText}) =>
      Column(
        children: [
          Text(
            keyText,
            style: GoogleFonts.quicksand(
              color: const Color.fromARGB(255, 64, 69, 87),
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            valueText,
            style: GoogleFonts.quicksand(
              color: const Color.fromARGB(255, 64, 69, 87),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );

  Widget avatarWidget() => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          children: [
            Stack(
              children: [
                GRADIENT_WIDGET(
                  child: const CircleAvatar(
                    maxRadius: 32,
                    minRadius: 32,
                  ),
                ),
                CircleAvatar(
                  maxRadius: 32,
                  minRadius: 32,
                  backgroundColor: Colors.transparent,
                  child: controller.accountModel.customerModel.avatar.isEmpty
                      ? CircleAvatar(
                          backgroundColor: PRIMARY_COLOR.withOpacity(0.7),
                          maxRadius: 29,
                          minRadius: 29,
                          child: Text(
                            controller
                                .accountModel.customerModel.avatarCharacter,
                            style: GoogleFonts.quicksand(
                              color: WHITE_COLOR,
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          maxRadius: 29,
                          minRadius: 29,
                          backgroundImage: NetworkImage(
                              controller.accountModel.customerModel.avatar),
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                controller.accountModel.customerModel.firstName +
                    ' ' +
                    controller.accountModel.customerModel.lastName,
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 64, 69, 87),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );
}
