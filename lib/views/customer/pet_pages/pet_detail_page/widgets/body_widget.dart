import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/health_records_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/pet_detail_information_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/services_combo_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PetDetailBodyWidget extends GetView<PetDetailPageController> {
  const PetDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      GetBuilder<PetDetailPageController>(builder: (_) {
        controller
          ..isLoadingData.value = true
          ..refreshController.refreshCompleted();

        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller
            ..petModel = await PetService.fetchPetById(
              jwt: controller.accountModel.jwtToken,
              petId: controller.petId.toString(),
            )
            ..isLoadingData.value = false;
        });
        return Obx(
          () => controller.isLoadingData.value
              ? Column(
                  children: [
                    const PetDetailTopWidget(),
                    Expanded(child: LOADING_WIDGET()),
                  ],
                )
              : Stack(
                  children: [
                    Column(
                      children: [
                        const PetDetailTopWidget(),
                        Expanded(
                          child: Container(
                            color: SUPPER_LIGHT_BLUE,
                            child: SmartRefresher(
                              controller: controller.refreshController,
                              onRefresh: () => controller.update(),
                              child: SingleChildScrollView(
                                controller: controller.scrollController,
                                child: Column(
                                  children: [
                                    Container(
                                      color: WHITE_COLOR,
                                      child: Column(
                                        children: [
                                          petDetailAvatarWidget(),
                                          CUSTOM_TEXT(
                                            controller.petModel.name,
                                            fontSize: 24,
                                            letterSpacing: 3,
                                            fontWeight: FontWeight.w700,
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                          ),
                                          CUSTOM_TEXT(
                                            '(${controller.petModel.breedModel!.name} - ${controller.petModel.breedModel!.speciesModel!.name})',
                                            fontSize: 18,
                                            letterSpacing: 2,
                                            color: DARK_GREY_TEXT_COLOR
                                                .withOpacity(0.8),
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                          ),
                                          viewTypeWidget(),
                                        ],
                                      ),
                                    ),
                                    Obx(() {
                                      switch (
                                          controller.selectedViewType.value) {
                                        case 'Health records':
                                          return const PetDetailHeathRecordsWidget();
                                        case 'Services combo':
                                          return const PetDetailServicesComboWidget();
                                        default:
                                          return const PetDetailInformationWidget();
                                      }
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.isOnTopScroll.value,
                        child: Column(
                          children: [
                            Container(
                              color: WHITE_COLOR,
                              margin: const EdgeInsets.only(top: 30),
                              child: viewTypeWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      });

  Widget viewTypeWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.viewTypes
            .asMap()
            .entries
            .map((e) => viewTypeItemWidget(viewType: e.value))
            .toList(),
      );

  Widget viewTypeItemWidget({required String viewType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () => controller.selectedViewType.value = viewType,
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedViewType.value == viewType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.selectedViewType.value == viewType
                          ? const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                maxRadius: 3,
                                backgroundColor: PRIMARY_COLOR,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        viewType,
                        style: GoogleFonts.quicksand(
                          color: controller.selectedViewType.value == viewType
                              ? PRIMARY_COLOR
                              : const Color.fromARGB(255, 116, 122, 143),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  color: controller.selectedViewType.value == viewType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );

  Widget petDetailAvatarWidget() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            GRADIENT_WIDGET(
              child: const CircleAvatar(
                maxRadius: 50,
                minRadius: 50,
              ),
            ),
            CircleAvatar(
              maxRadius: 50,
              minRadius: 50,
              backgroundColor: Colors.transparent,
              child: CircleAvatar(
                maxRadius: 46,
                minRadius: 46,
                backgroundImage: NetworkImage(controller.petModel.avatar),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () async {
                  // controller.avatarFile =
                  //     await PICK_IMAGE(isPickFromGalley: true);
                  // controller.avatarFile != null
                  //     ? controller.avatarFilePath.value =
                  //         controller.avatarFile!.path
                  //     : null;
                },
                child: const CircleAvatar(
                  backgroundColor: Color.fromARGB(210, 193, 204, 233),
                  child: Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 127, 137, 163),
                    size: 23,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
