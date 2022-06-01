import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/sale_post_detail_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/post.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
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
          body: Query(
              options: QueryOptions(
                document: gql(FETCH_PURCHASE_POST_BY_ID),
                variables: {'_postId': Get.parameters['salePostId']},
              ),
              builder: (
                QueryResult result, {
                VoidCallback? refetch,
                FetchMore? fetchMore,
              }) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return const Center(
                    child: SpinKitSpinningLines(
                      color: PRIMARY_COLOR,
                      size: 150,
                    ),
                  );
                }
                controller.postModel =
                    PostModel.fromJson(result.data!['post'][0]);
                return Column(
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
                );
              }),
        ),
      );
}
