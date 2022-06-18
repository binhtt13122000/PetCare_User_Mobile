import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/notification_page_controller.dart';

class NotificationPage extends GetView<NotificationPageController> {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            topWidget(),
            Expanded(
              child: Container(
                color: DARK_GREY_COLOR.withAlpha(20),
                child: notificationListItemWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationListItemWidget() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26, top: 12, bottom: 12),
              child: Text(
                'TODAY',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(color: DARK_GREY_COLOR.withAlpha(180)),
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  height: 1,
                ),
              ),
            ),
            notificationItemWidget(),
            notificationItemWidget(),
            notificationItemWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 26, top: 12, bottom: 12),
              child: Text(
                'YESTERDAY',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(color: DARK_GREY_COLOR.withAlpha(180)),
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  height: 1,
                ),
              ),
            ),
            notificationItemWidget(),
            notificationItemWidget(),
            notificationItemWidget(),
          ],
        ),
      );

  Widget notificationItemWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 30,
              top: 10,
            ),
            color: WHITE_COLOR,
            child: Row(
              children: [
                const CircleAvatar(
                  maxRadius: 5,
                  backgroundColor: Color.fromARGB(255, 98, 167, 231),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Husky is a general term for a dog used in the polar regions',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: DARK_GREY_COLOR.withAlpha(180),
                          ),
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          height: 1.3,
                        ),
                      ),
                      Text(
                        '1 hour ago',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 98, 167, 231),
                          ),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  ICON_PATH + ELLIPSIS_SVG,
                  height: 18,
                  color: const Color.fromARGB(255, 180, 204, 226),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
          Container(
            height: 21,
            color: WHITE_COLOR,
            child: Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(40),
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
            ),
          )
        ],
      );

  Widget topWidget() => Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    'Notifications',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.satisfy(
                      textStyle: const TextStyle(color: PRIMARY_COLOR),
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      height: 1,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: DARK_GREY_COLOR.withAlpha(30),
                    child: SvgPicture.asset(
                      ICON_PATH + CLOSE_SVG,
                      color: DARK_GREY_COLOR.withAlpha(180),
                      height: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      'Overall',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(color: PRIMARY_COLOR),
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 2.5,
                      width: 65,
                      color: PRIMARY_COLOR,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      'Unread',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(color: LIGHT_GREY_COLOR),
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    'Mark all as read',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(color: PRIMARY_COLOR),
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
