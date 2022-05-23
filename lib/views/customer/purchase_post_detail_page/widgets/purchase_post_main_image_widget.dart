import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_post_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PurchasePostDetailMainImageWidget
    extends GetView<PurchasePostDetailPageController> {
  const PurchasePostDetailMainImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          mainImageWidget(),
          backButtonWidget(),
          bookmarkButtonBackgroundWidget(),
          bookmarkButtonForegroundWidget(),
          moreInformationButtonBackgroundWidget(),
          moreInformationButtonForegroundWidget(),
          imageIndexWidget(),
        ],
      );

  Widget mainImageWidget() => Obx(
        () => Container(
          height: 330,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(controller.postModel
                  .mediaModels![controller.selectedPetImageIndex.value].url),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget backButtonWidget() => Positioned(
        left: 15,
        top: 30,
        child: InkWell(
          onTap: () => Get.back(),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: WHITE_COLOR.withOpacity(0.5),
            child: SvgPicture.asset(
              ICON_PATH + CLOSE_SVG,
              height: 15,
              color: const Color.fromARGB(255, 87, 107, 133),
            ),
          ),
        ),
      );

  Widget bookmarkButtonBackgroundWidget() => Positioned(
        right: 67,
        top: 30,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: WHITE_COLOR.withOpacity(0.5),
          child: GRADIENT_WIDGET(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 123, 41, 255),
              Color.fromARGB(255, 5, 209, 73),
            ]),
            child: SvgPicture.asset(
              ICON_PATH + BOOKMARK_SVG,
              height: 20,
              color: DARK_GREY_COLOR,
            ),
          ),
        ),
      );

  Widget bookmarkButtonForegroundWidget() => Positioned(
        right: 75.5,
        top: 38,
        child: InkWell(
          child: SvgPicture.asset(
            ICON_PATH + BOOKMARK_SVG,
            height: 20,
            color: WHITE_COLOR,
          ),
        ),
      );

  Widget moreInformationButtonBackgroundWidget() => Positioned(
        right: 15,
        top: 30,
        child: InkWell(
          child: CircleAvatar(
            radius: 20,
            backgroundColor: WHITE_COLOR.withOpacity(0.5),
            child: GRADIENT_WIDGET(
              child: SvgPicture.asset(
                ICON_PATH + ELLIPSIS_SVG,
                height: 15,
                color: DARK_GREY_COLOR,
              ),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 123, 41, 255),
                  Color.fromARGB(255, 5, 209, 73),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      );

  Widget moreInformationButtonForegroundWidget() => Positioned(
        right: 26.7,
        top: 40.8,
        child: InkWell(
          child: SvgPicture.asset(
            ICON_PATH + ELLIPSIS_SVG,
            height: 15,
            color: WHITE_COLOR,
          ),
        ),
      );

  Widget imageIndexWidget() => Obx(
        () => Positioned(
          right: 20,
          bottom: 20,
          child: Container(
            height: 40,
            width: 70,
            decoration: BoxDecoration(
              color: WHITE_COLOR.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: (controller.selectedPetImageIndex.value + 1) < 10
                ? Text(
                    '0${controller.selectedPetImageIndex.value + 1}/0${controller.postModel.mediaModels!.length}',
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 93, 107, 124),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  )
                : Text(
                    '${controller.selectedPetImageIndex.value + 1}/${controller.postModel.mediaModels!.length}',
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 93, 107, 124),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
          ),
        ),
      );
}
