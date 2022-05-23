import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_post_detail_page_controller.dart';
import 'package:petapp_mobile/services/chat_services.dart';

class PurchasePostDetailBottomWidget
    extends GetView<PurchasePostDetailPageController> {
  const PurchasePostDetailBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withOpacity(0.1),
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
                Container(
                  height: 40,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      width: 1,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                  child: Text(
                    'View health check',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    String? chatRoomId = await ChatServices.fetchChatRoomId(
                        buyerId: controller.accountModel.customerModel.id,
                        postId: controller.postModel.id);
                    chatRoomId != null
                        ? Get.toNamed(
                            '$CHATTING_DETAIL_PAGE_ROUNTER?chatRoomId=$chatRoomId')
                        : Get.toNamed(
                            '$CHATTING_DETAIL_PAGE_ROUNTER?sellerId=${controller.postModel.customerId}&postId=${controller.postModel.id}');
                  },
                  child: Container(
                    height: 40,
                    width: 190,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Contact seller to buy',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: WHITE_COLOR,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
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
