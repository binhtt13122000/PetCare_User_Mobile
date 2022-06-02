import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/sale_post_detail_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/post.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/post_services.dart';
import 'package:petapp_mobile/views/customer/sale_post_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/sale_post_detail_page/widgets/sale_post_detail_information_widget.dart';
import 'package:petapp_mobile/views/customer/sale_post_detail_page/widgets/sale_post_general_information_widget.dart';
import 'package:petapp_mobile/views/customer/sale_post_detail_page/widgets/sale_post_image_list_widget.dart';
import 'package:petapp_mobile/views/customer/sale_post_detail_page/widgets/sale_post_main_image_widget.dart';
import 'package:petapp_mobile/views/customer/sale_post_detail_page/widgets/seller_information_widget.dart';

class SalePostDetailPage extends GetView<SalePostDetailPageController> {
  const SalePostDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GraphQLProvider(
        client: GRAPHQL_CLIENT,
        child: Scaffold(
          backgroundColor: WHITE_COLOR,
          body: GetBuilder<SalePostDetailPageController>(
            builder: (_) {
              controller.isShowLoadingPost.value = true;
              WidgetsBinding.instance!.addPostFrameCallback((_) async {
                controller.postModel = await PostService.fetchPostById(
                    postId: int.parse(Get.parameters['salePostId'].toString()));
                controller.isShowLoadingPost.value = false;
              });
              return Obx(
                () => controller.isShowLoadingPost.value
                    ? Container(
                        color: const Color.fromARGB(75, 249, 236, 253),
                        child: const SpinKitSpinningLines(
                          color: PRIMARY_COLOR,
                          size: 150,
                        ),
                      )
                    : Column(
                        children: [
                          const PurchasePostDetailMainImageWidget(),
                          Expanded(
                            child: Scrollbar(
                              controller: controller.mainScrollController,
                              child: SingleChildScrollView(
                                controller: controller.mainScrollController,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    PurchasePostDetailImageListWidget(),
                                    PurchasePostDetailGeneralInformationWidget(),
                                    SellerInformationWidget(),
                                    PurchasePostDetailInformationWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const PurchasePostDetailBottomWidget(),
                        ],
                      ),
              );
            },
          ),
        ),
      );
}
