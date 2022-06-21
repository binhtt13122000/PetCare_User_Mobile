import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/generate_qr_code_page_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PetGenerateQrCodeBodyWidget extends GetView<GenerateQrCodeController> {
  const PetGenerateQrCodeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          controller.petDeepLink.value.isEmpty
              ? const Text("Can not generate Qr-Code")
              : QrImage(
                  data: controller.petDeepLink.value,
                  version: QrVersions.auto,
                  size: 320,
                  gapless: false,
                  errorStateBuilder: (cxt, err) {
                    return  const Center(
                      child: Text(
                        "Uh oh! Something went wrong...",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
          const Text("Generate another qr-code"),
        ],
      ),
    );
  }
}
