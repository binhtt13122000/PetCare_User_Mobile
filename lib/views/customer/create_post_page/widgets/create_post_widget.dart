import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/services/post_services.dart';

class CreatePostWidget extends GetView<CreatePostPageController> {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Obx(
            () => MaterialButton(
              height: 45,
              color: controller.title.value.isNotEmpty &&
                      controller.description.isNotEmpty
                  ? PRIMARY_COLOR
                  : PRIMARY_COLOR,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CREATE POST',
                    style: GoogleFonts.quicksand(
                      color: WHITE_COLOR,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    ICON_PATH + SEND_SVG,
                    color: WHITE_COLOR,
                    height: 18,
                  ),
                ],
              ),
              onPressed: () {
                // PostService.createPost(
                //     title: controller.title.value,
                //     price: controller.price.value,
                //     deposit: controller.deposit.value,
                //     refund: controller.moneyReceived.value,
                //     effectiveTime: DateTime.now().add(const Duration(days: 30)),
                //     description: controller.description,
                //     type: controller.selectedTicketType.value,
                //     petId: controller.selectedPetId,
                //     sellerId: 2,
                //     evidenceFilesPath: controller.evidencesPath,
                //     healthCheckFilesPath: []);
                print(jsonEncode(
                    controller.quillController.document.toDelta().toJson()));
              },
            ),
          ),
        ),
      );
}
