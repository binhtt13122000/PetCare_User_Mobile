import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_list_page_controller.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_filter_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/post_filter_page/widgets/top_widget.dart';

class PostsFilterPage extends GetView<PostListPageController> {
  const PostsFilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          PostFilterTopWidget(),
          PostFilterBodyWidget(),
        ],
      ),
    );
  }
}
