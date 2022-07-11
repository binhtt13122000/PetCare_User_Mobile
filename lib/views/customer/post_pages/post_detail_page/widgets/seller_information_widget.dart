import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PostDetailSellerInformationWidget
    extends GetView<PostDetailPageController> {
  const PostDetailSellerInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Visibility(
        visible: controller.accountModel.customerModel.id !=
            controller.postModel.customerId,
        child: Column(
          children: [
            topInformationWidget(),
            // bottomInformationWidget(),
            Container(
              height: 1,
              //  margin: const EdgeInsets.only(top: 10),
              color: LIGHT_GREY_COLOR.withOpacity(0.1),
            ),
            Container(
              height: 8,
              color: const Color.fromARGB(255, 247, 248, 250),
            ),
          ],
        ),
      );

  Widget topInformationWidget() => Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
          bottom: 12,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                GRADIENT_WIDGET(
                  child: const CircleAvatar(
                    radius: 19.5,
                  ),
                ),
                controller.postModel.customerModel!.avatar == null ||
                        controller.postModel.customerModel!.avatar!.isEmpty
                    ? CircleAvatar(
                        backgroundColor: PRIMARY_COLOR.withOpacity(0.7),
                        maxRadius: 19.5,
                        minRadius: 19.5,
                        child: Text(
                          controller.postModel.customerModel!.avatarCharacter,
                          style: GoogleFonts.quicksand(
                            color: WHITE_COLOR,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 19.5,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: PRIMARY_COLOR,
                          backgroundImage: NetworkImage(
                              controller.postModel.customerModel!.avatar!),
                        ),
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        '${controller.postModel.customerModel!.firstName} ${controller.postModel.customerModel!.lastName}',
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 56, 75, 97),
                          height: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        ICON_PATH + CLOCK_SVG,
                        height: 11,
                        color: const Color.fromARGB(255, 121, 136, 153),
                      ),
                      const SizedBox(
                        width: 3.5,
                      ),
                      Text(
                        FORMAT_DATE_TIME(
                            dateTime: controller.postModel.createTime,
                            pattern: DATE_TIME_PATTERN),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          color: const Color.fromARGB(255, 121, 136, 153),
                          height: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 30,
                  width: 20,
                  decoration: BoxDecoration(
                    color: LIGHT_GREY_COLOR.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ICON_PATH + ELLIPSIS_SVG,
                        height: 18,
                        color: const Color.fromARGB(255, 122, 160, 201),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget bottomInformationWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller.postModel.customerModel!.numberReviewers
                      .toString(),
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 86, 104, 126),
                  ),
                ),
                Text(
                  'Reviews',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 86, 104, 126),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: 1,
              color: const Color.fromARGB(255, 141, 157, 177),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: controller.postModel.customerModel!.star,
                  itemCount: 5,
                  itemSize: 17,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  unratedColor: Colors.amber.withOpacity(0.4),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rate_rounded,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (_) {},
                ),
                Text(
                  'Stars',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 86, 104, 126),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: 1,
              color: const Color.fromARGB(255, 141, 157, 177),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '10',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 86, 104, 126),
                  ),
                ),
                Text(
                  'Posts',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 86, 104, 126),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
