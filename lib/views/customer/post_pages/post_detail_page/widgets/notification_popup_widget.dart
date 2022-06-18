import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PostDetailNotificationPopupWidget
    extends GetView<PostDetailPageController> {
  const PostDetailNotificationPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowNotificationPopup.value
            ? InkWell(
                onTap: () => controller.isShowNotificationPopup.value = false,
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
                              CUSTOM_TEXT(controller.notificationPopupTitle),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Icon(
                                  Icons.verified,
                                  color: PRIMARY_COLOR,
                                  size: 70,
                                ),
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
                                        onPressed: () async {
                                          controller
                                            ..isShowNotificationPopup.value =
                                                false
                                            ..update();
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
                            onTap: () => controller
                                .isShowNotificationPopup.value = false,
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
