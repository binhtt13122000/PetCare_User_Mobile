import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/update_sale_post_page_controller.dart';

class UpdateSalePostPage extends GetView<UpdateSalePostPageController> {
  const UpdateSalePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('aaaaaaaa' + Get.parameters['salePostId'].toString());
    return Container();
  }
}
