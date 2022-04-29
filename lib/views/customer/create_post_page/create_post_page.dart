import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/create_post_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/desciption_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/media_picker_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/pet_filter_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/post_price_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/top_widget.dart';

class CreatePostPage extends GetView<CreatePostPageController> {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        extendBody: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TopWidget(),
            Expanded(
              child: Scrollbar(
                controller: controller.mainScrollController,
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  controller: controller.mainScrollController,
                  child: Column(
                    children: const [
                      BodyWidget(),
                      PostPriceWidget(),
                      SelectPetWidget(),
                      PetFilterWidget(),
                      MediaPickerWidget(),
                      DescriptionWidget(),
                      CreatePostWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
