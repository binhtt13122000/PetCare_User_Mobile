import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_detail_page_controller.dart';
import 'package:petapp_mobile/services/post_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PostDetailConfirmPopupWidget extends GetView<PostDetailPageController> {
  const PostDetailConfirmPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowConfirmPopup.value
            ? InkWell(
                onTap: () => controller.isShowConfirmPopup.value = false,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                controller.isShowConfirmPopup.value = false,
                          ),
                        ),
                        Container(
                          width: 340,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CUSTOM_TEXT('Are you sure to '),
                                  CUSTOM_TEXT(
                                    controller.confirmType == 'REOPEN'
                                        ? 'reopen'
                                        : 'cancel',
                                    fontWeight: FontWeight.w700,
                                    color: controller.confirmType == 'REOPEN'
                                        ? GREEN_COLOR
                                        : RED_COLOR,
                                    fontSize: 18,
                                  ),
                                  CUSTOM_TEXT(' this post?'),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () => controller
                                          ..isShowConfirmPopup.value = false
                                          ..isShowMoreOptionWidget.value =
                                              false,
                                        color: PRIMARY_LIGHT_COLOR,
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.quicksand(
                                            color: PRIMARY_COLOR,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () async {
                                          controller
                                            ..isShowConfirmPopup.value = false
                                            ..isShowMoreOptionWidget.value =
                                                false
                                            ..isWaitLoadingDataForeGround
                                                .value = true;
                                          await PostService
                                              .updatePostStatusByPostId(
                                                  postStatus:
                                                      controller.confirmType ==
                                                              'REOPEN'
                                                          ? 'REQUESTED'
                                                          : 'CANCELED',
                                                  postId:
                                                      controller.postModel.id,
                                                  isVaccineInject: controller
                                                      .postModel
                                                      .isVaccineInject);
                                          controller
                                            ..notificationPopupTitle = controller
                                                        .confirmType ==
                                                    'REOPEN'
                                                ? 'Reopen post successfully!'
                                                : 'Cancel post successfully!'
                                            ..isWaitLoadingDataForeGround
                                                .value = false
                                            ..isShowNotificationPopup.value =
                                                true;
                                        },
                                        color: PRIMARY_COLOR,
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.quicksand(
                                            color: WHITE_COLOR,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                controller.isShowConfirmPopup.value = false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      );
}
