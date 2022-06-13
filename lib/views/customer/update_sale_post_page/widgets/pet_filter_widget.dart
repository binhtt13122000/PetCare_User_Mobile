import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/update_sale_post_page_controller.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/breed_services.dart';
import 'package:petapp_mobile/services/species_services.dart';

class PetFilterWidget extends GetView<UpdateSalePostPageController> {
  const PetFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !controller.isShowPetFilter.value
          ? const SizedBox.shrink()
          : GetBuilder<UpdateSalePostPageController>(
              builder: (_) {
                controller.isShowLoadingPetSpecies.value = true;
                WidgetsBinding.instance!
                    .addPostFrameCallback((timeStamp) async {
                  controller.species = await SpeciesService.fetchSpeciesList();
                  controller.selectedSpeciesId ??= controller.species[0].id;
                  controller.isShowLoadingPetSpecies.value = false;
                });
                return Obx(
                  () => controller.isShowLoadingPetSpecies.value
                      ? const SpinKitSpinningLines(
                          color: PRIMARY_COLOR,
                          size: 40,
                        )
                      : Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Text(
                                  'Pet species',
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                    color: const Color.fromARGB(
                                        255, 106, 122, 143),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            listSpeciesWidget(),
                          ],
                        ),
                );
              },
            ),
    );
  }

  Widget listSpeciesWidget() => Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 40, top: 10),
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              spacing: 10,
              runSpacing: 10,
              children: controller.species
                  .asMap()
                  .entries
                  .map((e) => speciesItemWidget(speciesModel: e.value))
                  .toList(),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 40, top: 10),
          //     child: Text(
          //       'Pet breeds',
          //       style: GoogleFonts.quicksand(
          //         fontWeight: FontWeight.w500,
          //         fontStyle: FontStyle.italic,
          //         color: const Color.fromARGB(255, 106, 122, 143),
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),
          // listBreedItemWidget(),
        ],
      );

  Widget speciesItemWidget({required SpeciesModel speciesModel}) =>
      GetBuilder<UpdateSalePostPageController>(
        builder: (_) => Container(
          width: 55 + speciesModel.name.length * 10,
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              controller.selectedSpeciesId = speciesModel.id;
              controller.update();
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: controller.selectedSpeciesId == speciesModel.id
                    ? PRIMARY_COLOR
                    : PRIMARY_COLOR.withOpacity(0.13),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: controller.selectedSpeciesId == speciesModel.id
                        ? PRIMARY_COLOR.withOpacity(0.7)
                        : WHITE_COLOR,
                    offset: const Offset(1, 1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    speciesModel.imageUrl!,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    speciesModel.name,
                    style: GoogleFonts.itim(
                      color: speciesModel.id == controller.selectedSpeciesId
                          ? WHITE_COLOR
                          : PRIMARY_COLOR.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget listBreedItemWidget() => GetBuilder<UpdateSalePostPageController>(
        builder: (_) {
          controller.isLoadingBreeds.value = true;
          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            controller.breedsMap[controller.selectedSpeciesId!] =
                await BreedService.fetchBreedListBySpeciesId(
                    speciesId: controller.selectedSpeciesId!);

            if (controller.selectedBreedMap[controller.selectedSpeciesId] ==
                null) {
              controller.selectedBreedMap[controller.selectedSpeciesId!] = -1;
            }
            controller.isLoadingBreeds.value = false;
          });
          return Obx(
            () => controller.isLoadingBreeds.value
                ? const Center(
                    child: SpinKitSpinningLines(
                      color: PRIMARY_COLOR,
                      size: 150,
                    ),
                  )
                : controller.breedsMap[controller.selectedSpeciesId] != null &&
                        controller
                            .breedsMap[controller.selectedSpeciesId]!.isNotEmpty
                    ? Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 40,
                          top: 10,
                          right: 30,
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          spacing: 10,
                          runSpacing: 10,
                          children: controller
                              .breedsMap[controller.selectedSpeciesId]!
                              .asMap()
                              .entries
                              .map((e) => breedItemWidget(breedModel: e.value))
                              .toList(),
                        ),
                      )
                    : Text(
                        'No suitable breeds!',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 244, 55, 159),
                          fontSize: 16,
                        ),
                      ),
          );
        },
      );

  Widget breedItemWidget({required BreedModel breedModel}) =>
      GetBuilder<UpdateSalePostPageController>(
        builder: (_) => InkWell(
          onTap: () {
            controller.selectedBreedMap[controller.selectedSpeciesId]! ==
                    breedModel.id
                ? controller.selectedBreedMap[controller.selectedSpeciesId!] =
                    -1
                : controller.selectedBreedMap[controller.selectedSpeciesId!] =
                    breedModel.id;
            controller.update();
          },
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color:
                  controller.selectedBreedMap[controller.selectedSpeciesId] !=
                              null &&
                          controller.selectedBreedMap[
                                  controller.selectedSpeciesId]! ==
                              breedModel.id
                      ? PRIMARY_COLOR
                      : WHITE_COLOR,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: controller.selectedBreedMap[
                                  controller.selectedSpeciesId] !=
                              null &&
                          controller.selectedBreedMap[
                                  controller.selectedSpeciesId]! ==
                              breedModel.id
                      ? PRIMARY_COLOR.withOpacity(0.7)
                      : WHITE_COLOR,
                  offset: const Offset(1, 1),
                  blurRadius: 8,
                ),
              ],
              border: Border.all(
                color: PRIMARY_COLOR.withOpacity(0.7),
                width: 1.5,
              ),
            ),
            child: Text(
              breedModel.name,
              style: GoogleFonts.itim(
                color:
                    controller.selectedBreedMap[controller.selectedSpeciesId] !=
                                null &&
                            controller.selectedBreedMap[
                                    controller.selectedSpeciesId] ==
                                breedModel.id
                        ? WHITE_COLOR
                        : PRIMARY_COLOR.withOpacity(0.7),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
        ),
      );
}
