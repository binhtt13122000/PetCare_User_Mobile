import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_detail_page_controller.dart';
import 'package:petapp_mobile/services/other_services/chat_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PostDetailBottomWidget extends GetView<PostDetailPageController> {
  const PostDetailBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            color: WHITE_COLOR,
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Visibility(
                //   visible: controller.accountModel.customerModel.id !=
                //       controller.postModel.customerId,
                //   child: Container(
                //     height: 40,
                //     width: 150,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(15),
                //       ),
                //       border: Border.all(
                //         width: 1,
                //         color: PRIMARY_COLOR,
                //       ),
                //     ),
                //     child: Text(
                //       'View health check',
                //       style: GoogleFonts.quicksand(
                //         fontSize: 14,
                //         color: PRIMARY_COLOR,
                //         fontWeight: FontWeight.w500,
                //         letterSpacing: 1,
                //       ),
                //     ),
                //   ),
                // ),
                Visibility(
                  visible: controller.accountModel.customerModel.id ==
                          controller.postModel.customerId &&
                      (controller.postModel.status == 'REQUESTED' ||
                          controller.postModel.status == 'CANCELED' ||
                          controller.postModel.status == 'REJECTED'),
                  child: Expanded(
                    child: InkWell(
                      onTap: () => controller.postModel.status == 'REQUESTED'
                          ? Get.toNamed(
                              '$UPDATE_SALE_POST_PAGE_ROUTE/${controller.postModel.id}')
                          : {
                              controller
                                ..confirmType = 'REOPEN'
                                ..isShowConfirmPopup.value = true
                            },
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          controller.postModel.status == 'REQUESTED'
                              ? 'Update Post Information'
                              : 'Reopen Post',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            color: WHITE_COLOR,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.accountModel.customerModel.id !=
                      controller.postModel.customerId,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: InkWell(
                        onTap: () async {
                          String? chatRoomId =
                              await ChatServices.fetchChatRoomId(
                                  jwt: controller.accountModel.jwtToken,
                                  buyerId:
                                      controller.accountModel.customerModel.id,
                                  postId: controller.postModel.id);
                          chatRoomId != null
                              ? Get.toNamed(
                                  '$CHATTING_DETAIL_PAGE_ROUTE/$chatRoomId')
                              : Get.toNamed(
                                  '$CHATTING_DETAIL_PAGE_ROUTE/sellerId/${controller.postModel.customerId}/postId/${controller.postModel.id}');
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: PRIMARY_COLOR,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CUSTOM_TEXT('Contact Seller To Buy',
                                  fontSize: 14,
                                  color: WHITE_COLOR,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  padding: const EdgeInsets.only(right: 10)),
                              SvgPicture.asset(
                                ICON_PATH + SEND_SVG,
                                color: WHITE_COLOR,
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
}
