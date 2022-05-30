import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_posts_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/views/customer/sale_post_list_page/widgets/purchase_porst_list_widget.dart';
import 'package:petapp_mobile/views/customer/sale_post_list_page/widgets/top_widget.dart';

class SalePostListPage extends GetView<PurchasePostsPageController> {
  const SalePostListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GraphQLProvider(
        client: GRAPHQL_CLIENT,
        child: Scaffold(
          backgroundColor: WHITE_COLOR,
          extendBody: true,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 33),
                decoration: const BoxDecoration(
                  color: WHITE_COLOR,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 198, 206, 223),
                      offset: Offset(1, 1),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: const SalePostTopWidget(),
              ),
              const SalePostListWidget(),
            ],
          ),
        ),
      );
}
