import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_post_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SellerInformationWidget
    extends GetView<PurchasePostDetailPageController> {
  const SellerInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          topInformationWidget(),
          bottomInformationWidget(),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10),
            color: LIGHT_GREY_COLOR.withOpacity(0.1),
          ),
          Container(
            height: 8,
            color: const Color.fromARGB(255, 247, 248, 250),
          ),
        ],
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
                const CircleAvatar(
                  radius: 19.5,
                  backgroundColor: Colors.transparent,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: PRIMARY_COLOR,
                    backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/a-/AOh14Giq7w5GSupG5JXnHM2i-4yAYESAoR3VpEdVFQ1Bkg=s288-p-rw-no'),
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
                        'Lập đẹp trai',
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
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'follow',
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: PRIMARY_COLOR,
                          height: 1,
                          fontWeight: FontWeight.w500,
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
                            dateTime: controller.postModel.createTime!,
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
                  '9',
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
                  initialRating: 3.5,
                  itemCount: 5,
                  itemSize: 17,
                  allowHalfRating: true,
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
                  '5',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 86, 104, 126),
                  ),
                ),
                Text(
                  'Followers',
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
