import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/register_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PickImageWidget extends GetView<RegisterPageController> {
  const PickImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isSelectPickImageType.value,
        child: InkWell(
          onTap: () => controller.isSelectPickImageType.value = false,
          child: Container(
            color: const Color.fromARGB(78, 224, 225, 230),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 180,
                width: 300,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 215, 220, 241),
                      spreadRadius: 2,
                      offset: Offset(1, 1),
                      blurStyle: BlurStyle.normal,
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: InkWell(
                        onTap: () =>
                            controller.isSelectPickImageType.value = false,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: DARK_GREY_COLOR.withOpacity(0.2),
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            ICON_PATH + CLOSE_SVG,
                            height: 10,
                            color: PRIMARY_COLOR,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cameraButtonWidget(),
                          gallerylButtonWidget(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cameraButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () async {
            controller.avatarFile = await PICK_IMAGE(isPickFromGalley: false);
            controller.avatarFile != null
                ? controller.avatarFilePath.value = controller.avatarFile!.path
                : null;
            controller.isSelectPickImageType.value = false;
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 192, 195, 207),
              ),
              borderRadius: BorderRadius.circular(3),
              color: const Color.fromARGB(255, 243, 243, 243),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pick image from Camera',
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 64, 69, 87),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    fontSize: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SvgPicture.asset(
                    ICON_PATH + CAMERA_SVG,
                    color: const Color.fromARGB(255, 64, 69, 87),
                    height: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget gallerylButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () async {
            controller.avatarFile = await PICK_IMAGE();
            controller.avatarFile != null
                ? controller.avatarFilePath.value = controller.avatarFile!.path
                : null;
            controller.isSelectPickImageType.value = false;
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 192, 195, 207),
              ),
              borderRadius: BorderRadius.circular(3),
              color: const Color.fromARGB(255, 243, 243, 243),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pick image from Gallery',
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 64, 69, 87),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.6,
                    fontSize: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SvgPicture.asset(
                    ICON_PATH + GALLERY_SVG,
                    color: const Color.fromARGB(255, 64, 69, 87),
                    height: 16.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
