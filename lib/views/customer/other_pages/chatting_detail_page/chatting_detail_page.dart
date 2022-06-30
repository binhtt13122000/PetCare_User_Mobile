import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/services/other_services/chat_services.dart';
import 'package:petapp_mobile/services/other_services/customer_services.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/other_pages/chatting_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/chatting_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/chatting_detail_page/widgets/buyer_request_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/chatting_detail_page/widgets/create_request_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/chatting_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';

class ChattingDetailPage extends GetView<ChattingDetailPageController> {
  const ChattingDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLoadingChat.value = true;
    String? tmpChatRoomId = Get.parameters['chatRoomId'];
    String? tmpPostId = Get.parameters['postId'];
    String? tmpSellerId = Get.parameters['sellerId'];
    if (tmpChatRoomId != null) {
      controller.chatRoomId = tmpChatRoomId;
    }
    if (tmpPostId != null) {
      controller.postId = tmpPostId;
    }
    if (tmpSellerId != null) {
      controller.sellerId = tmpSellerId;
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (controller.chatRoomId != null) {
        controller.chatRoomModel = await ChatServices.fetchChatRoomById(
            chatRoomId: controller.chatRoomId!);
        //*location
        controller.transactionLocationTextEditingController.text =
            controller.chatRoomModel!.transactionPlace ?? '';
        controller.transactionLocation.value =
            controller.chatRoomModel!.transactionPlace ?? '';
        //*time
        controller.transactionTime = controller.chatRoomModel!.transactionTime;
        controller.tmpTransactionTime = controller.transactionTime;
        if (controller.transactionTime != null) {
          controller.transactionTimeText.value = FORMAT_DATE_TIME(
              dateTime: controller.transactionTime!, pattern: DATE_PATTERN_2);
        }
        //*description
        controller.descriptionTextEditingController.text =
            controller.chatRoomModel!.description ?? '';
        controller.description.value =
            controller.chatRoomModel!.description ?? '';
        controller.messageModelList
            .addAll(await ChatServices.fetchMessageListByChatRoomId(
          chatRoomId: Get.parameters['chatRoomId']!,
          limit: controller.limitMessageRange,
          skip: controller.messageModelList.length,
        ));
        controller.sortListMessage();

        controller.anotherChatRoomMember =
            await CustomerService.fetchCustomerById(
          controller.chatRoomModel!.buyerId ==
                  controller.accountModel.customerModel.id
              ? controller.chatRoomModel!.sellerId
              : controller.chatRoomModel!.buyerId,
        );

        controller.postModel = await PostService.fetchPostById(
            postId: controller.chatRoomModel!.postId);

        controller.socket.emit('joinRoom', controller.chatRoomModel!.id);
        controller.isLoadingChat.value = false;
      } else {
        controller.anotherChatRoomMember =
            await CustomerService.fetchCustomerById(
          int.parse(controller.sellerId!),
        );
        controller.postModel = await PostService.fetchPostById(
            postId: int.parse(controller.postId!));
        controller.isLoadingChat.value = false;
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Obx(
        () => !controller.isLoadingChat.value
            ? Stack(
                children: [
                  Column(
                    children: const [
                      ChattingDetailTopWidget(),
                      ChattingDetailBodyWidget(),
                      ChattingDetailBottomWidget(),
                    ],
                  ),
                  const CreateRequestWidget(),
                  const BuyerRequestWidget(),
                  Obx(
                    () => controller.isShowFailedNotificationPopup.value
                        ? NotificationPopupWidget(
                            onTapBackground: () => controller
                                .isShowFailedNotificationPopup.value = false,
                            onTapOk: () => controller
                                .isShowFailedNotificationPopup.value = false,
                            content:
                                'Approve for buyer request failed. This post already has a transaction.',
                            isSuccessNotification: false,
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(() => controller.isWaitLoadingData.value
                      ? Container(
                          child: LOADING_WIDGET(),
                          color: DARK_GREY_TRANSPARENT,
                        )
                      : const SizedBox.shrink())
                ],
              )
            : LOADING_WIDGET(),
      ),
    );
  }
}
