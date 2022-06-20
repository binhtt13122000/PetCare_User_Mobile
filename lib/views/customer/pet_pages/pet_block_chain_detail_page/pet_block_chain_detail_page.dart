import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_block_chain_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_block_chain_detail_page/widgets/top_widget.dart';

class PetBlockChainDetailPage extends GetView<PetBlockChainPageController> {
  const PetBlockChainDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller
      ..chainIndex = int.parse(Get.parameters['chainId']!)
      ..petChainValueModel =
          controller.petChainModel.valueModelList[controller.chainIndex]
      ..setListPetHealthRecord();

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(children: const [
        PetBlockChainDetailTopWidget(),
        PetBlockChainDetailBodyWidget(),
      ]),
    );
  }
}
