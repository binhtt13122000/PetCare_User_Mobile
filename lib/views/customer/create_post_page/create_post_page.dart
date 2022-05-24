import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/desciption_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/loading_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/media_picker_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/pet_filter_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/top_widget.dart';
// import 'package:petapp_mobile/views/customer/create_post_page/widgets/video_displayer_widget.dart';

class CreatePostPage extends GetView<CreatePostPageController> {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CreatePostTopWidget(),
                Expanded(
                  child: Scrollbar(
                    controller: controller.mainScrollController,
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                      controller: controller.mainScrollController,
                      child: Column(
                        children: const [
                          //VideoApp(),
                          CreatePostBodyWidget(),
                          SelectPetWidget(),
                          PetFilterWidget(),
                          MediaPickerWidget(),
                          DescriptionWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
                const CreatePostBottomWidget(),
              ],
            ),
            const CreatePostLoadingWidget(),
            const CreatePostPopupWidget(),
          ],
        ),
      ),
    );
  }
}
