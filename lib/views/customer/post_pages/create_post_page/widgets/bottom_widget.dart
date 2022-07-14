import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreatePostBottomWidget extends GetView<CreatePostPageController> {
  const CreatePostBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withAlpha(50),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: InkWell(
                onTap: () async {
                  if (controller.title.value.isNotEmpty &&
                      controller.price.value > 0 &&
                      controller.selectedPetIndex.value != -1 &&
                      controller.evidences.isNotEmpty &&
                      controller.meetingTimeText.value.isNotEmpty) {
                    controller.isShowLoadingWidget.value = true;
                    await PostService.createPost(
                      title: controller.title.value,
                      sellerReceive: int.parse(controller.receivedMoney.value),
                      shopFee: controller.price.value -
                          int.parse(controller.receivedMoney.value),
                      transactionTotal: controller.price.value,
                      deposits: controller.price.value,
                      createTime: DateTime.now(),
                      meetingTime: controller.meetingTime!,
                      type: controller.selectedPostType.value,
                      petId:
                          controller.pets[controller.selectedPetIndex.value].id,
                      customerId: controller.accountModel.customerModel.id,
                      filesPath: controller.evidencesPath,
                      status: 'REQUESTED',
                      branchId: controller
                          .branchModelList[controller.selectBranchIndex.value]
                          .id,
                    );
                    controller.isShowLoadingWidget.value = false;
                    controller.isShowSuccessfullyPopup.value = true;
                  }
                },
                child: Obx(
                  () => Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: controller.title.value.isNotEmpty &&
                              controller.price.value > 0 &&
                              controller.selectedPetIndex.value != -1 &&
                              controller.evidences.isNotEmpty
                          ? PRIMARY_COLOR
                          : PRIMARY_COLOR.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CUSTOM_TEXT(
                          'Create Post',
                          textAlign: TextAlign.center,
                          color: WHITE_COLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SvgPicture.asset(
                            ICON_PATH + ADD_SVG,
                            color: WHITE_COLOR,
                            height: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
