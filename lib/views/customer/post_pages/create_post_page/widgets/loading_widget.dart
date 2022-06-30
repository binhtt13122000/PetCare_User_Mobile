import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreatePostLoadingWidget extends GetView<CreatePostPageController> {
  const CreatePostLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isShowLoadingWidget.value,
        child: Container(
          color: DARK_GREY_TRANSPARENT,
          child: LOADING_WIDGET(),
        ),
      ),
    );
  }
}
