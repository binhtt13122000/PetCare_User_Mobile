import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/update_sale_post_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/post.dart';
import 'package:petapp_mobile/services/post_services.dart';
import 'package:petapp_mobile/services/transaction_fees_services.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/desciption_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/loading_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/media_picker_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/pet_filter_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/sale_transaction_fees.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/selecte_branch_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/widgets/video_displayer_widget.dart';

class UpdateSalePostPage extends GetView<UpdateSalePostPageController> {
  const UpdateSalePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: GetBuilder<UpdateSalePostPageController>(builder: (_) {
          controller.isShowMainLoading.value = true;
          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            QueryResult result = await CLIENT_TO_QUERY().query(
              QueryOptions(
                document: gql(FETCH_PURCHASE_POST_BY_ID),
                variables: {'_postId': Get.parameters['salePostId']},
              ),
            );
      
            controller.postModel = PostService.getPost(result.data!['post'][0]);
            controller.title.value = controller.postModel.title;
            controller.description.value = controller.postModel.description ?? "";
            controller.selectedPostType.value = controller.postModel.type;
            controller.deposit.value = controller.postModel.deposit ?? 0;
            controller.receivedMoney.value = controller.postModel.sellerReceive.toString();
            controller.price.value = controller.postModel.provisionalTotal;
            controller.selectedBranchId.value = controller.postModel.branchId;
            controller.selectedPetId = controller.postModel.petId;
            // controller.deletedIds.value = [];

            controller.titleEditingController.text = controller.postModel.title;
            controller.receiveMoneyEditingController.text = controller.postModel.sellerReceive.toString();
            controller.depositEditingController.text = controller.postModel.deposit != null ? controller.postModel.deposit.toString() : "";
            print(controller.postModel.mediaModels!.length);
            if(controller.postModel.mediaModels != null) {
              controller.evidencesPath.value = controller.postModel.mediaModels!;
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
                          color: const Color.fromARGB(75, 249, 236, 253),
                          child: const SpinKitSpinningLines(
                            color: PRIMARY_COLOR,
                            size: 150,
                          ),
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
