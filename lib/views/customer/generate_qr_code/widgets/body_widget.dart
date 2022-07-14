import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/generate_qr_code_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PetGenerateQrCodeBodyWidget extends GetView<GenerateQrCodeController> {
  const PetGenerateQrCodeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        margin: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.petDeepLink.value.isEmpty
                    ? const Text("Can not generate Qr-Code")
                    : QrImage(
                        data: controller.petDeepLink.value,
                        version: QrVersions.auto,
                        size: 270,
                        gapless: false,
                        errorStateBuilder: (cxt, err) {
                          return const Center(
                            child: Text(
                              "Uh oh! Something went wrong...",
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CUSTOM_TEXT(
                            'Automatically update after ${controller.countDownTime.value}s.',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            textAlign: TextAlign.center,
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            fontSize: 12,
                          ),
                          controller.countDownTime.value < 55
                              ? InkWell(
                                  child: CUSTOM_TEXT('Update',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                      textAlign: TextAlign.center,
                                      fontSize: 12,
                                      color: Colors.pink),
                                  onTap: () {
                                    if (controller.timerUpdate.isActive) {
                                      controller.timerUpdate.cancel();
                                    }
                                    controller.update();
                                  },
                                )
                              : Container()
                        ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
