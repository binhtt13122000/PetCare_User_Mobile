import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/widgets/top_widget.dart';

class PetManagementPage extends GetView<PetManagementPageController> {
  const PetManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: const [
            PetsManagementTopWidget(),
            Expanded(child: PetsManagementBodyWidget()),
            PetsManagementBottomWidget(),
          ],
        ),
      ),
    );
  }
}
