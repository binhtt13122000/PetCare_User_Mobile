import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/update_sale_post_page_controller.dart';
import 'package:petapp_mobile/models/media_model/media_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class MediaPickerWidget extends GetView<UpdateSalePostPageController> {
  const MediaPickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
      ),
      child: Column(
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10),
            color: LIGHT_GREY_COLOR.withOpacity(0.1),
          ),
          Container(
            height: 8,
            color: const Color.fromARGB(255, 247, 248, 250),
          ),
          titleWidget(),
          mediasWidget(),
          pickMediasFromGalleryWidget(),
          pickMediasFromCameraWidget(),
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
      ),
    );
  }

  Widget titleWidget() => Padding(
        padding: const EdgeInsets.only(left: 20, top: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Post medias ',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 78, 98, 124),
                fontSize: 16,
              ),
            ),
            Text(
              '(Images or videos)',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 78, 98, 124),
                fontSize: 15,
              ),
            ),
            Text(
              '*',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w800,
                color: const Color.fromARGB(255, 241, 99, 88),
                fontSize: 20,
              ),
            ),
          ],
        ),
      );

  Widget pickMediasFromGalleryWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: InkWell(
          onTap: () async {
            File? mediaFile = await PICK_IMAGE(isPickFromGalley: true);
            if (mediaFile != null) {
              controller.evidences.add(mediaFile);
              controller.evidencesPath.add(MediaModel(url: mediaFile.path));
            }
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: PRIMARY_LIGHT_COLOR,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pick medias from Gallery',
                  style: GoogleFonts.quicksand(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  ICON_PATH + GALLERY_SVG,
                  color: PRIMARY_COLOR,
                  height: 23,
                ),
              ],
            ),
          ),
        ),
      );

  Widget pickMediasFromCameraWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: InkWell(
          onTap: () async {
            File? mediaFile = await PICK_IMAGE(isPickFromGalley: false);
            if (mediaFile != null) {
              controller.evidences.add(mediaFile);
              controller.evidencesPath.add(MediaModel(url: mediaFile.path));
            }
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: PRIMARY_LIGHT_COLOR,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pick medias from Camera',
                  style: GoogleFonts.quicksand(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  ICON_PATH + CAMERA_SVG,
                  color: PRIMARY_COLOR,
                  height: 23,
                ),
              ],
            ),
          ),
        ),
      );

  Widget mediasWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Obx(() {
          return controller.evidencesPath.isNotEmpty
              ? Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 10,
                      children: controller.evidencesPath
                          .asMap()
                          .entries
                          .map((e) => imageItemWidget(index: e.key))
                          .toList(),
                    ),
                  ),
                )
              : Container(
                  height: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 237, 240, 243),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No medias have \nbeen selected yet!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.itim(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: const Color.fromARGB(255, 127, 136, 148),
                          letterSpacing: 1,
                        ),
                      ),
                      // SvgPicture.asset(
                      //   ICON_PATH + NO_IMAGE_SVG,
                      //   color: const Color.fromARGB(255, 159, 169, 182),
                      //   height: 25,
                      // ),
                    ],
                  ),
                );
        }),
      );

  Widget imageItemWidget({required int index}) => Obx(
        () => Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
              child: controller.evidencesPath[index].id != null
                  ? Image.network(
                      controller.evidencesPath[index].url,
                      height: 180,
                    )
                  : Image.file(
                      File(controller.evidencesPath[index].url),
                      height: 180,
                    ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: InkWell(
                onTap: () => {
                  if(controller.evidencesPath[index].id != null) {
                    // ignore: invalid_use_of_protected_member
                    controller.deletedIds.value.add(controller.evidencesPath[index].id ?? 0)
                  },
                  controller.evidencesPath.removeAt(index)
                },
                child: Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 167, 53, 255),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    'x',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                      color: WHITE_COLOR,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                width: 35,
                height: 25,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  (index + 1).toString() +
                      ' / ' +
                      controller.evidencesPath.length.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                    color: const Color.fromARGB(255, 167, 53, 255),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
