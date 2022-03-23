import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PurchasePostsWidget extends GetView<HomePageController> {
  const PurchasePostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: CustomScrollView(
          slivers: [
            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 0.63,
              mainAxisSpacing: 5,
              crossAxisSpacing: 4,
              children: controller.postList
                  .asMap()
                  .entries
                  .map(
                    (e) => purchasePostItemWidget(index: e.key),
                  )
                  .toList(),
            )
          ],
        ),
      );

  Widget purchasePostItemWidget({required int index}) => InkWell(
        onTap: () {
          Get.toNamed(POST_DETAIL_PAGE_ROUNTER);
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(0.3),
                blurRadius: 6,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(7),
                      ),
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: NetworkImage(
                                controller.postList[index].petModel!.avatar),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5.5,
                      left: 6.5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          controller.postList[index].petModel!.breedModel.name,
                          style: GoogleFonts.satisfy(
                            color: PRIMARY_COLOR.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(71, 123, 6, 212),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(15, 10),
                          ),
                        ),
                        child: Text(
                          controller.postList[index].petModel!.breedModel.name,
                          style: GoogleFonts.satisfy(
                            color: WHITE_COLOR,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    //*Time Created
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                ICON_PATH + CLOCK_SVG,
                                height: 11,
                                color: WHITE_COLOR,
                              ),
                              const SizedBox(
                                width: 3.5,
                              ),
                              Text(
                                FORMAT_DATE_TIME(
                                    dateTime:
                                        controller.postList[index].createTime!,
                                    pattern: TIME_PATTERN),
                                style: GoogleFonts.quicksand(
                                  color: WHITE_COLOR,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            FORMAT_DATE_TIME(
                                dateTime:
                                    controller.postList[index].createTime!,
                                pattern: DATE_PATTERN),
                            style: GoogleFonts.quicksand(
                              color: WHITE_COLOR,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 5, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.postList[index].title!,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        color: const Color.fromARGB(211, 32, 32, 32),
                        height: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Price: ',
                        style: GoogleFonts.quicksand(
                          color: DARK_GREY_COLOR.withOpacity(0.8),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: FORMAT_MONEY(
                                price: controller.postList[index].price!),
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w700,
                              color: PRIMARY_COLOR,
                              fontSize: 17,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Wrap(
                      spacing: 8,
                      children: [
                        SizedBox(
                          height: 25,
                          width: 70,
                          child: Material(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            color:
                                controller.postList[index].petModel!.gender ==
                                        'MALE'
                                    ? const Color.fromARGB(255, 225, 233, 248)
                                    : const Color.fromARGB(255, 253, 228, 242),
                            child: Wrap(
                              spacing: 4,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  controller.postList[index].petModel!.gender ==
                                          'MALE'
                                      ? ICON_PATH + MALE_SVG
                                      : ICON_PATH + FEMALE_SVG,
                                  color: controller.postList[index].petModel!
                                              .gender ==
                                          'MALE'
                                      ? const Color.fromARGB(255, 39, 111, 245)
                                      : const Color.fromARGB(255, 244, 55, 165),
                                  height: 12,
                                ),
                                Text(
                                  controller.postList[index].petModel!.gender,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                    color: controller.postList[index].petModel!
                                                .gender ==
                                            'MALE'
                                        ? const Color.fromARGB(
                                            255, 39, 111, 245)
                                        : const Color.fromARGB(
                                            255, 244, 55, 165),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                            color: DARK_GREY_COLOR.withOpacity(0.13),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Text(
                            controller.postList[index].petModel!.ageRange
                                    .toString() +
                                ' Month',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              color: DARK_GREY_COLOR.withOpacity(0.7),
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
