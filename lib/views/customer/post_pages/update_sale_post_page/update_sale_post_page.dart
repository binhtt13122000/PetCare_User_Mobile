import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_sale_post_page_controller.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/services/transaction_services/transaction_fees_services.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/loading_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/media_picker_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/pet_filter_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/sale_transaction_fees.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/select_branch_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/update_sale_post_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class UpdateSalePostPage extends GetView<UpdateSalePostPageController> {
  const UpdateSalePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GetBuilder<UpdateSalePostPageController>(builder: (_) {
          controller.isShowMainLoading.value = true;
          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            controller.postModel = await PostService.fetchPostById(
                postId: int.parse(Get.parameters['salePostId'].toString()));
            controller.title.value = controller.postModel.title;
            controller.description.value =
                controller.postModel.description ?? "";
            controller.selectedPostType.value = controller.postModel.type;
            controller.deposit.value = controller.postModel.deposit ?? 0;
            controller.receivedMoney.value =
                controller.postModel.sellerReceive.toString();
            controller.price.value = controller.postModel.provisionalTotal;
            controller.selectedBranchId.value = controller.postModel.branchId;
            controller.selectedPetId.value = controller.postModel.petId;
            // controller.deletedIds.value = [];

            controller.titleEditingController.text = controller.postModel.title;
            controller.receiveMoneyEditingController.text =
                controller.postModel.sellerReceive.toString();
            controller.depositEditingController.text =
                controller.postModel.deposit != null
                    ? controller.postModel.deposit.toString()
                    : "";
            if (controller.postModel.mediaModels != null) {
              controller.evidencesPath.value =
                  controller.postModel.mediaModels!;
            }
            controller.listPurchaseTransactionFees =
                await TransactionFeesServices.fetchTransactionFreesList(
                    transactionType: controller.selectedPostType.value);
            controller.isShowMainLoading.value = false;
          });

          return Stack(
            children: [
              Obx(
                () => controller.isShowMainLoading.value
                    ? Container(
                        color: DARK_GREY_TRANSPARENT,
                        child: LOADING_WIDGET(),
                      )
                    : Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const UpdatePostTopWidget(),
                              Expanded(
                                child: Scrollbar(
                                  controller: controller.mainScrollController,
                                  isAlwaysShown: true,
                                  child: SingleChildScrollView(
                                    controller: controller.mainScrollController,
                                    child: Column(
                                      children: const [
                                        UpdatePostBodyWidget(),
                                        SelectPetWidget(),
                                        PetFilterWidget(),
                                        MediaPickerWidget(),
                                        SelectBranchWidget(),
                                        // DescriptionWidget(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const UpdatePostBottomWidget(),
                            ],
                          ),
                          const UpdatePostLoadingWidget(),
                          const UpdatePostPopupWidget(),
                          const SaleTransactionFeesWidget(),
                        ],
                      ),
              ),
            ],
          );
        }),
      );
}
