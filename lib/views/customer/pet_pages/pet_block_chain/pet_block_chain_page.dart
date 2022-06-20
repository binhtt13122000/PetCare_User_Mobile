import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_chain_services.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_block_chain/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_block_chain/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetBlockChainPage extends GetView<PetBlockChainPageController> {
  const PetBlockChainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['petId'] != null) {
      controller.petId = int.parse(Get.parameters['petId']!);
    }
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(children: [
            const PetBlockChainTopWidget(),
            GetBuilder<PetBlockChainPageController>(builder: (_) {
              controller.isWaitingLoadingData.value = true;
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
                controller
                  ..petModel = await PetService.fetchPetById(
                      petId: controller.petId.toString())
                  ..petChainModel = await PetChainService.fetchPetChainByPetId(
                      petId: controller.petId.toString())
                  ..isWaitingLoadingData.value = false;
              });
              return Obx(() => controller.isWaitingLoadingData.value
                  ? Expanded(child: LOADING_WIDGET())
                  : const PetBlockChainBodyWidget());
            })
          ]),
          Obx(
            () => Visibility(
              visible: controller.isShowTimelineTitle.value,
              child: Column(
                children: [
                  Container(
                    color: WHITE_COLOR,
                    margin: const EdgeInsets.only(top: 105),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CUSTOM_TEXT('Pet History Timeline',
                                textAlign: TextAlign.center,
                                letterSpacing: 1,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20)),
                          ],
                        ),
                        Container(
                          height: 1,
                          color: LIGHT_GREY_COLOR.withAlpha(30),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
