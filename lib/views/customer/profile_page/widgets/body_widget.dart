import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/profile_page_controller.dart';

class ProfilePageBodyWidget extends GetView<ProfilePageController> {
  const ProfilePageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 50),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 210),
                child: inviteFriendWidget(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pointCardWidget(),
                  addPetProfileCard(),
                ],
              ),
            ],
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 20),
            color: LIGHT_GREY_COLOR.withOpacity(0.1),
          ),
          Container(
            height: 8,
            color: const Color.fromARGB(255, 245, 248, 253),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 40),
            child: Column(
              children: [
                buttonCartWidget(
                  iconData: Icons.pets,
                  title: 'Pets management',
                  onTap: () => Get.toNamed(PET_MANAGEMENT_PAGE_ROUTE),
                ),
                buttonCartWidget(
                  svgUrl: ICON_PATH + POSTS_SVG,
                  title: 'Posts management',
                  onTap: () => Get.toNamed(POST_MANAGEMENT_PAGE_ROUNTER),
                ),
                buttonCartWidget(
                  iconData: Icons.bookmark_border_outlined,
                  title: 'Posts marked',
                  onTap: () {},
                ),
                buttonCartWidget(
                  iconData: Icons.help_outline_outlined,
                  title: 'Help',
                  onTap: () {},
                ),
                buttonCartWidget(
                  iconData: Icons.settings,
                  title: 'Settings',
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget inviteFriendWidget() => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Stack(
          children: [
            Container(
              height: 100,
              margin: const EdgeInsets.only(top: 40, left: 17, right: 17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 238, 240, 253),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invite your friends',
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 62, 68, 87),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'Refer your friends to join \niU Petshop and together get \n500 bonus points.',
                          style: GoogleFonts.quicksand(
                            color: const Color.fromARGB(255, 62, 68, 87),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 18,
              child: Image.asset(
                IMAGE_PATH + PRETTY_PET_PNG,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 5,
              right: 80,
              child: Container(
                height: 25,
                width: 130,
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(242, 240, 243, 247),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: const Color.fromARGB(255, 204, 211, 218),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Invite now',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        color: PRIMARY_COLOR,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.add_box_outlined,
                        color: PRIMARY_COLOR,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget buttonCartWidget(
          {IconData? iconData,
          String? svgUrl,
          required String title,
          required Function()? onTap}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
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
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: iconData != null
                    ? Icon(
                        iconData,
                        color: const Color.fromARGB(255, 62, 68, 87),
                      )
                    : SvgPicture.asset(
                        svgUrl!,
                        height: 22,
                        color: const Color.fromARGB(255, 62, 68, 87),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 62, 68, 87),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget addPetProfileCard() => InkWell(
        onTap: () => Get.toNamed(CREATE_PET_PAGE_ROUTE),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.asset(
                IMAGE_PATH + CAT_ART_1_PNG,
                width: 160,
                height: 210,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 30,
                    width: 140,
                    margin: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: PRIMARY_COLOR,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add pet profile',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            color: const Color.fromARGB(255, 240, 243, 247),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SvgPicture.asset(
                            ICON_PATH + ADD_SVG,
                            color: const Color.fromARGB(255, 240, 243, 247),
                            height: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget pointCardWidget() => Stack(
        children: [
          Container(
            width: 160,
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromARGB(253, 17, 16, 23),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  IMAGE_PATH + CRYSTAL_GIF,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 125,
            child: SizedBox(
              width: 160,
              child: Column(
                children: [
                  Text(
                    'Reward',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 203, 210, 233),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Many gifts are waiting\n for you to redeem!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 203, 210, 233),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 140,
                    margin: const EdgeInsets.only(top: 18),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 203, 210, 233),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Image.asset(
                            IMAGE_PATH + CRYSTAL_POINTS_PNG,
                            height: 20,
                          ),
                        ),
                        Text(
                          controller.accountModel.customerModel.point
                                  .toString() +
                              ' points',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            color: const Color.fromARGB(255, 62, 68, 87),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
}
