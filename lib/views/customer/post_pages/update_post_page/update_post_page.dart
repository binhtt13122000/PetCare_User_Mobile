import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_post_page_controller.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/services/transaction_services/transaction_fees_services.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_post_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_post_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_post_page/widgets/description_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_post_page/widgets/media_picker_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_post_page/widgets/sale_transaction_fees.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_post_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/confirm_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';

class UpdatePostPage extends GetView<UpdatePostPageController> {
  const UpdatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? postIdText = Get.parameters['postId'];
    if (postIdText != null) {
      controller.postId = int.parse(postIdText);
    }
    return Scaffold(
      body: GetBuilder<UpdatePostPageController>(builder: (_) {
        controller.isShowMainLoading.value = true;
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller
            ..postModel =
                await PostService.fetchPostById(postId: controller.postId)
            ..title.value = controller.postModel.title
            ..description.value = controller.postModel.description ?? ""
            ..receivedMoney.value =
                controller.postModel.sellerReceive.toString()
            ..price.value = controller.postModel.transactionTotal
            ..selectedBranchId.value = controller.postModel.branchId;

          if (controller.postModel.mediaModels != null) {
            controller.evidencesPath.value = controller.postModel.mediaModels!;
          }
          controller
            ..listPurchaseTransactionFees =
                await TransactionFeesServices.fetchTransactionFreesList(
                    transactionType: controller.postModel.type)
            ..isShowMainLoading.value = false;
        });

        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const UpdatePostTopWidget(),
                Obx(
                  () => controller.isShowMainLoading.value
                      ? Expanded(child: LOADING_WIDGET())
                      : Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: const [
                                      UpdatePostBodyWidget(),
                                      MediaPickerWidget(),
                                      UpdatePostDescriptionWidget(),
                                    ],
                                  ),
                                ),
                              ),
                              const UpdatePostBottomWidget(),
                            ],
                          ),
                        ),
                ),
              ],
            ),
            const SaleTransactionFeesWidget(),
            Obx(
              () => controller.isShowConfirmPopup.value
                  ? ConfirmPopupWidget(
                      onTapBackground: () {
                        controller.isShowConfirmPopup.value = false;
                      },
                      title: 'Update post',
                      content:
                          'Are you sure to update post #${controller.postModel.id} ?',
                      onTapSubmit: () async {
                        controller
                          ..isShowConfirmPopup.value = false
                          ..isWaitingUpdate.value = true;
                        await PostService.updatePost(
                          id: controller.postModel.id,
                          title: controller.title.value,
                          sellerReceive:
                              int.parse(controller.receivedMoney.value),
                          shopFee: controller.price.value -
                              int.parse(controller.receivedMoney.value),
                          transactionTotal: controller.price.value,
                          deposits: controller.price.value,
                          createTime: DateTime.now(),
                          meetingTime: DateTime.now(),
                          type: controller.postModel.type,
                          petId: controller.postModel.petId,
                          customerId: controller.accountModel.customerModel.id,
                          mediaModels: controller.evidencesPath,
                          status: 'REQUESTED',
                          branchId: controller.selectedBranchId.value,
                          deletedIds: controller.deletedIds,
                        );

                        controller
                          ..isWaitingUpdate.value = false
                          ..isShowSuccessfullyPopup.value = true;
                      })
                  : const SizedBox.shrink(),
            ),
            Obx(
              () => controller.isShowSuccessfullyPopup.value
                  ? NotificationPopupWidget(
                      onTapBackground: () {},
                      onTapOk: () => Get
                        ..back()
                        ..find<PostDetailPageController>().update(),
                      content:
                          'Update post #${controller.postModel.id} successfully.',
                    )
                  : const SizedBox.shrink(),
            ),
            Obx(
              () => Visibility(
                visible: controller.isWaitingUpdate.value,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  child: LOADING_WIDGET(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
