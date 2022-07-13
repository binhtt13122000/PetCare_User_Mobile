import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/update_pet_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/pet_pages/update_pet_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/update_pet_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/update_pet_page/widgets/calender_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/update_pet_page/widgets/loading_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/update_pet_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/update_pet_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class UpdatePetPage extends GetView<UpdatePetPageController> {
  const UpdatePetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WHITE_COLOR,
        body: GetBuilder<UpdatePetPageController>(builder: (_) {
          controller.isLoadingData.value = true;

          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            controller.petModel = await PetService.fetchPetById(
              petId:
                  Get.parameters['petId'] ?? controller.petModel.id.toString(),
            );
            controller.petName.value = controller.petModel.name;
            controller.textEditingNameController.text =
                controller.petModel.name;

            controller.avatarUrl.value = controller.petModel.avatar;

            controller.selectedGender.value = controller.petModel.gender;

            controller.dateOfBirthTime = controller.petModel.dob;
            controller.dayOfBirthText.value = FORMAT_DATE_TIME(
                dateTime: controller.petModel.dob, pattern: DATE_PATTERN_2);

            controller.selectedFertility.value =
                controller.petModel.isFertility ? "YES" : "NO";

            controller.color.value = controller.petModel.color ?? "";
            controller.textEditingColorController.text =
                controller.petModel.color ?? "";

            controller.specialMarkings.value =
                controller.petModel.specialMarkings ?? "";
            controller.textEditingSpecialMarkingsController.text =
                controller.petModel.specialMarkings ?? "";

            controller.description.value =
                controller.petModel.description ?? "";
            controller.textEditingDescriptionController.text =
                controller.petModel.description ?? "";

            controller.selectedBreedsId.value =
                controller.petModel.breedId ?? 0;
            controller.selectedSpeciesId.value =
                controller.petModel.breedModel?.speciesId ?? 0;
          });
          controller.isLoadingData.value = false;
          return Obx(() => controller.isLoadingData.value
              ? Expanded(
                  child: LOADING_WIDGET(),
                )
              : Stack(
                  children: [
                    Column(
                      children: const [
                        UpdatePetTopWidget(),
                        UpdatePetBodyWidget(),
                        UpdatePetBottomWidget(),
                      ],
                    ),
                    const UpdatePetCalenderWidget(),
                    const UpdatePetLoadingWidget(),
                    const UpdatePetPopupWidget(),
                  ],
                ));
        }));
  }
}
