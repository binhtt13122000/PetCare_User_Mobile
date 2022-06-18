import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_sale_post_page_controller.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';

class UpdatePostBottomWidget extends GetView<UpdateSalePostPageController> {
  const UpdatePostBottomWidget({Key? key}) : super(key: key);

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
                      controller.selectedPetId.value != -1 &&
                      controller.evidences.isNotEmpty) {
                    controller.isShowLoadingWidget.value = true;
                    await PostService.updatePost(
                      id: controller.postModel.id,
                      title: controller.title.value,
                      sellerReceive: int.parse(controller.receivedMoney.value),
                      shopFee: controller.price.value -
                          int.parse(controller.receivedMoney.value),
                      provisionalTotal: controller.price.value,
                      deposits: controller.price.value,
                      createTime: DateTime.now(),
                      meetingTime: DateTime.now(),
                      type: controller.selectedPostType.value,
                      petId: controller.selectedPetId.value,
                      customerId: controller.accountModel.customerModel.id,
                      mediaModels: controller.evidencesPath,
                      status: 'REQUESTED',
                      branchId: controller.selectedBranchId.value,
                      deletedIds: controller.deletedIds,
                    );
                    controller.isShowLoadingWidget.value = false;
                    controller.isShowSuccessfullyPopup.value = true;
                  }
                },
                child: Obx(
                  () => Container(
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: controller.title.value.isNotEmpty &&
                              controller.price.value > 0 &&
                              controller.selectedPetId.value != -1 &&
                              controller.evidences.isNotEmpty
                          ? PRIMARY_COLOR
                          : PRIMARY_COLOR.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Update Post',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(color: WHITE_COLOR),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            height: 1,
                            letterSpacing: 2,
                          ),
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
