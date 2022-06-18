import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_detail_page_controller.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/more_option_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/notification_popup_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/confirm_pop_up_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/post_detail_information_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/post_general_information_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/post_image_list_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/post_main_image_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_detail_page/widgets/seller_information_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PostDetailPage extends GetView<PostDetailPageController> {
  const PostDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: GetBuilder<PostDetailPageController>(
          builder: (_) {
            controller.isShowLoadingPost.value = true;

            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              controller.postModel = await PostService.fetchPostById(
                  postId: Get.parameters['postId'] != null
                      ? int.parse(Get.parameters['postId'].toString())
                      : controller.postModel.id);
              controller.isShowLoadingPost.value = false;
            });

            return Obx(
              () => controller.isShowLoadingPost.value
                  ? const Center(
                      child: SpinKitSpinningLines(
                        color: PRIMARY_COLOR,
                        size: 150,
                      ),
                    )
                  : Stack(
                      children: [
                        Column(
                          children: [
                            const PostDetailMainImageWidget(),
                            Expanded(
                              child: Scrollbar(
                                controller: controller.mainScrollController,
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
                        const PostDetailConfirmPopupWidget(),
                        Obx(
                          () => Visibility(
                            visible:
                                controller.isWaitLoadingDataForeGround.value,
                            child: Container(
                              color: DARK_GREY_TRANSPARENT,
                              child: LOADING_WIDGET(),
                            ),
                          ),
                        ),
                        const PostDetailNotificationPopupWidget(),
                      ],
                    ),
            );
          },
        ),
      );
}
