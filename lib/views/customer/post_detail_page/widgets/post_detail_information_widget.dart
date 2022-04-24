import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_post_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PostDetailInformationWidget
    extends GetView<PurchasePostDetailPageController> {
  const PostDetailInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                ),
                child: Text(
                  'Pet detail information',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 68, 91, 119),
                  ),
                ),
              ),
              // Container(
              //   height: 0.7,
              //   color: const Color.fromARGB(255, 212, 220, 230),
              //   margin: const EdgeInsets.only(
              //     left: 25,
              //     right: 25,
              //     top: 5,
              //     bottom: 5,
              //   ),
              // ),
              speciesCardWidget(),
              textCardWidget(
                keyText: 'Breed',
                valueText: controller.postModel.petModel!.breedModel.name,
              ),
              genderCardWidget(),
              textCardWidgetWithInfoIcon(
                keyText: 'Age',
                valueText: controller.postModel.petModel!.ageRange.toString() +
                    ' months',
              ),
              textCardWidget(
                keyText: 'Date of birth',
                valueText: FORMAT_DATE_TIME(
                  dateTime: controller.postModel.petModel!.dob!,
                  pattern: DATE_PATTERN,
                ),
              ),
              colorCardWidget(),
              textCardWidget(
                keyText: 'Weight',
                valueText: '7.5 Kilogram',
              ),
              textCardWidget(
                keyText: 'Fertility',
                valueText: 'YES',
              ),
              textCardWidgetWithInfoIcon(
                keyText: 'Genealogy certificate',
                valueText: 'YES',
              ),
              textCardWidgetWithInfoIcon(
                keyText: 'Vaccinated',
                valueText: 'NO',
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.only(top: 10),
          color: LIGHT_GREY_COLOR.withOpacity(0.1),
        ),
        Container(
          height: 8,
          color: const Color.fromARGB(255, 247, 248, 250),
        ),
        descriptionCardWidget(),
      ],
    );
  }

  Widget descriptionCardWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Obx(
          () => Column(
            children: [
              InkWell(
                onTap: () {
                  controller.isShowDescription.value =
                      !controller.isShowDescription.value;

                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    controller.mainScrollController.animateTo(
                      controller.mainScrollController.position.maxScrollExtent,
                      duration: Duration(
                          milliseconds:
                              controller.isShowDescription.value ? 2000 : 500),
                      curve: Curves.ease,
                    );
                  });
                },
                child: SizedBox(
                  width: 180,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.isShowDescription.value
                                ? 'Hide post description'
                                : 'View post description',
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            controller.isShowDescription.value
                                ? Icons.keyboard_double_arrow_up_outlined
                                : Icons.keyboard_double_arrow_down_outlined,
                            size: 18,
                            color: PRIMARY_COLOR,
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: PRIMARY_COLOR,
                        margin: const EdgeInsets.only(
                          top: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              controller.isShowDescription.value
                  ? Html(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      data: r"""<div>
          <h1>Demo Page</h1>
          <p>This is a fantastic product that you should buy!</p>
          <h3>Features</h3>
          <ul>
            <li>It actually works</li>
            <li>It exists</li>
            <li>It doesn't cost much!</li>
          </ul>
          <!--You can pretty much put any html in here!-->
              </div>""",
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );

  Widget textCardWidget({
    required String keyText,
    required String valueText,
  }) =>
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              keyText,
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
            Text(
              valueText,
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
          ],
        ),
      );

  Widget speciesCardWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Species',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  IMAGE_PATH + CAT_PNG,
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    controller
                        .postModel.petModel!.breedModel.speciesModel!.name,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 86, 104, 126),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget genderCardWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gender',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  controller.postModel.petModel!.gender == 'MALE'
                      ? ICON_PATH + MALE_SVG
                      : ICON_PATH + FEMALE_SVG,
                  height: 13,
                  color: const Color.fromARGB(255, 101, 152, 214),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    controller.postModel.petModel!.gender,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 101, 152, 214),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget textCardWidgetWithInfoIcon({
    required String keyText,
    required String valueText,
  }) =>
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  keyText,
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 86, 104, 126),
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.info_outline_rounded,
                  size: 15,
                  color: Color.fromARGB(255, 135, 151, 172),
                ),
              ],
            ),
            Text(
              valueText,
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
          ],
        ),
      );

  Widget colorCardWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Colors',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Colors.brown.withOpacity(0.5),
                        border: Border.all(
                          width: 1,
                          color: LIGHT_GREY_COLOR,
                        ),
                      ),
                    ),
                    Text(
                      'Brown ,',
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 86, 104, 126),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      margin: const EdgeInsets.only(
                        right: 5,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: LIGHT_GREY_COLOR,
                        ),
                      ),
                    ),
                    Text(
                      'White',
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
          ],
        ),
      );
}
