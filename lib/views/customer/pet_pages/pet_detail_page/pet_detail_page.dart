import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/more_option_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/top_widget.dart';

class PetDetailPage extends GetView<PetDetailPageController> {
  const PetDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.isLoadingData.value = true;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller.petModel = await PetService.fetchPetById(
        petId: Get.parameters['petId'] ?? controller.petModel.id.toString(),
      );
      controller.isLoadingData.value = false;
    });
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const PetDetailTopWidget(),
              Obx(
                () => controller.isLoadingData.value
                    ? const Expanded(
                        child: Center(
                          child: SpinKitSpinningLines(
                            color: PRIMARY_COLOR,
                            size: 150,
                          ),
                        ),
                      )
                    : const PetDetailBodyWidget(),
              ),
            ],
          ),
          const PetDetailMoreOptionWidget(),
        ],
      ),
    );
  }
}
