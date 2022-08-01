import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/generate_qr_code_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PetGenerateQrCodeBodyWidget extends GetView<GenerateQrCodeController> {
  const PetGenerateQrCodeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Image.asset(
            IMAGE_PATH + FONDOS_BACKGROUND_PNG,
            fit: BoxFit.cover,
            height: 700,
          ),
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    controller.petDeepLink.value.isEmpty
                        ? const Text("Can not generate Qr-Code")
                        : Stack(
                            children: [
                              GRADIENT_WIDGET(
                                child: Container(
                                  height: 250,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: WHITE_COLOR,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin:
                                    const EdgeInsets.only(left: 15, top: 15),
                                height: 220,
                                width: 220,
                                child: QrImage(
                                  data: controller.petDeepLink.value,
                                  version: QrVersions.auto,
                                  constrainErrorBounds: true,
                                  size: 100,
                                  gapless: false,
                                  // embeddedImage:
                                  //     const AssetImage(IMAGE_PATH + APP_LOGO_PNG),
                                  // embeddedImageStyle: QrEmbeddedImageStyle(
                                  //   size: const Size(40, 40),
                                  // ),
                                  dataModuleStyle: const QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.circle,
                                  ),
                                  eyeStyle: const QrEyeStyle(
                                      eyeShape: QrEyeShape.circle),
                                  foregroundColor: PRIMARY_COLOR,
                                  errorStateBuilder: (cxt, err) {
                                    return const Center(
                                      child: Text(
                                        "Uh oh! Something went wrong...",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CUSTOM_TEXT('Automatically update QR after ',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  textAlign: TextAlign.center,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  fontSize: 12,
                                  color: WHITE_COLOR),
                              CUSTOM_TEXT('${controller.countDownTime.value}s',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  fontSize: 12,
                                  color: GREEN_COLOR),
                              // controller.countDownTime.value < 55
                              //     ? InkWell(
                              //         child: CUSTOM_TEXT('Update',
                              //             fontWeight: FontWeight.w600,
                              //             letterSpacing: 1,
                              //             textAlign: TextAlign.center,
                              //             fontSize: 12,
                              //             color: Colors.pink),
                              //         onTap: () {
                              //           if (controller.timerUpdate.isActive) {
                              //             controller.timerUpdate.cancel();
                              //           }
                              //           controller.update();
                              //         },
                              //       )
                              //     : Container()
                            ])),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
