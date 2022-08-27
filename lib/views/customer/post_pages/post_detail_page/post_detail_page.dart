import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_detail_page_controller.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/more_option_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/post_detail_information_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/post_general_information_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/post_image_list_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/post_main_image_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/seller_information_widget.dart';
import 'package:petapp_mobile/views/widgets/confirm_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostDetailPage extends GetView<PostDetailPageController> {
  const PostDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['postId'] != null) {
      controller.postId = int.parse(Get.parameters['postId'].toString());
    }
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: GetBuilder<PostDetailPageController>(
        builder: (_) {
          controller.isShowLoadingPost.value = true;

          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            controller.postModel = await PostService.fetchPostById(
              postId: controller.postId,
              jwt: controller.accountModel.jwtToken,
            );
            controller.isShowLoadingPost.value = false;
          });

          return Obx(
            () => controller.isShowLoadingPost.value
                ? LOADING_WIDGET()
                : Stack(
                    children: [
                      Column(
                        children: [
                          const PostDetailMainImageWidget(),
                          Expanded(
                            child: SmartRefresher(
                              controller: controller.refreshController,
                              onRefresh: () => controller.update(),
                              child: SingleChildScrollView(
                                controller: controller.mainScrollController,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    PostDetailImageListWidget(),
                                    PostDetailGeneralInformationWidget(),
                                    PostDetailSellerInformationWidget(),
                                    PostDetailInformationWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const PostDetailBottomWidget(),
                        ],
                      ),
                      const PostDetailMoreOptionWidget(),
                      Obx(
                        () => Visibility(
                          visible: controller.isWaitLoadingDataForeGround.value,
                          child: Container(
                            color: DARK_GREY_TRANSPARENT,
                            child: LOADING_WIDGET(),
                          ),
                        ),
                      ),

                      //const PostDetailNotificationPopupWidget(),
                      //Sorry, your pet status is not available to reopen this post
                      Obx(
                        () => controller.isShowNotificationPopup.value
                            ? NotificationPopupWidget(
                                onTapBackground: () {},
                                onTapOk: () => controller
                                  ..isShowNotificationPopup.value = false
                                  ..update(),
                                isSuccessNotification:
                                    controller.isSuccessNotification,
                                content: controller.notificationPopupTitle,
                              )
                            : const SizedBox.shrink(),
                      ),
                      Obx(
                        () => controller.isShowConfirmPopup.value
                            ? ConfirmPopupWidget(
                                content: controller.confirmType == 'REOPEN'
                                    ? 'Are you sure to reopen this post?'
                                    : 'Are you sure to cancel this post?',
                                onTapBackground: () =>
                                    controller.isShowConfirmPopup.value = false,
                                onTapSubmit: () async {
                                  controller
                                    ..isShowConfirmPopup.value = false
                                    ..isShowMoreOptionWidget.value = false
                                    ..isWaitLoadingDataForeGround.value = true;
                                  controller.isSuccessNotification =
                                      await PostService
                                          .updatePostStatusByPostId(
                                    jwt: controller.accountModel.jwtToken,
                                    postStatus:
                                        controller.confirmType == 'REOPEN'
                                            ? 'REQUESTED'
                                            : 'CANCELED',
                                    postId: controller.postModel.id,
                                  );
                                  controller
                                    ..notificationPopupTitle = controller
                                                .confirmType ==
                                            'REOPEN'
                                        ? controller.isSuccessNotification
                                            ? 'Reopen post successfully.'
                                            : 'Sorry, reopen post failed. Your pet status\nis not available to reopen this post.'
                                        : controller.isSuccessNotification
                                            ? 'Cancel post successfully.'
                                            : 'Sorry, cancel post failed.\nSomething went wrong.'
                                    ..isWaitLoadingDataForeGround.value = false
                                    ..isShowNotificationPopup.value = true;
                                },
                                title: controller.confirmType == 'REOPEN'
                                    ? 'Reopen Post'
                                    : 'Cancel Post',
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
