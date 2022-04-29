import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_post_detail_page_controller.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/widgets/post_detail_information_widget.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/widgets/post_general_information_widget.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/widgets/post_image_list_widget.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/widgets/post_main_image_widget.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/widgets/seller_information_widget.dart';

class PurchasePostDetaiPage extends GetView<PurchasePostDetailPageController> {
  const PurchasePostDetaiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: [
            const PostMainImageWidget(),
            Expanded(
              child: Scrollbar(
                controller: controller.mainScrollController,
                child: SingleChildScrollView(
                  controller: controller.mainScrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      PostImageListWidget(),
                      PostGeneralInformationWidget(),
                      SellerInformationWidget(),
                      PostDetailInformationWidget(),
                    ],
                  ),
                ),
              ),
            ),
            const BottomWidget(),
          ],
        ),
      );
}
