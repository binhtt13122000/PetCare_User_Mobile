import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/add_pet_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/views/customer/create_pet_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/create_pet_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/create_pet_page/widgets/calender_widget.dart';
import 'package:petapp_mobile/views/customer/create_pet_page/widgets/loading_widget.dart';
import 'package:petapp_mobile/views/customer/create_pet_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/create_pet_page/widgets/top_widget.dart';

class CreatePetPage extends GetView<CreatePetPageController> {
  const CreatePetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Stack(
          children: [
            Column(
              children: const [
                CreatePetTopWidget(),
                CreatePetBodyWidget(),
                CreatePetBottomWidget(),
              ],
            ),
            const CeatePetCalenderWidget(),
            const CreatePetLoadingWidget(),
            const CreatePetPopupWidget(),
          ],
        ),
      ),
    );
  }

  // loadModel() async {
  //   await Tflite.loadModel(
  //     model: 'assets/model_unquant.tflite',
  //     labels: 'assets/labels.txt',
  //   );
  // }
}
