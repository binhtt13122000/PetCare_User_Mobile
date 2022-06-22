import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_list_page_controller.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_list_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_list_page/widgets/top_widget.dart';

class PostListPage extends GetView<PostListPageController> {
  const PostListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        extendBody: true,
        body: Column(
          children: [
            const PostListTopWidget(),
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
            const PostListBodyWidget(),
          ],
        ),
      );
}
