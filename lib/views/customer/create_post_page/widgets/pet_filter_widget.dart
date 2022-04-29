import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/graphql/query_mutation/breed.dart';
import 'package:petapp_mobile/graphql/query_mutation/species.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/breed_servies.dart';
import 'package:petapp_mobile/services/species_services.dart';

class PetFilterWidget extends GetView<CreatePostPageController> {
  const PetFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Visibility(
            visible: controller.isShowPetFilter.value,
            child: Column(
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
                        color: const Color.fromARGB(255, 106, 122, 143),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                listSpeciesWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget listSpeciesWidget() => Query(
        options: QueryOptions(document: gql(FETCH_ALL_SPECIES), variables: {}),
        builder: (
          QueryResult result, {
          VoidCallback? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          } else if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (result.data != null) {
            controller.species = SpeciesService.getSpeciesList(result.data!);
            controller.selectedSpeciesId == -1
                ? controller.selectedSpeciesId = controller.species[0].id
                : null;
          }

          return Column(
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, top: 10),
                  child: Text(
                    'Pet breeds',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: const Color.fromARGB(255, 106, 122, 143),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              listBreedItemWidget(),
            ],
          );
        },
      );

  Widget speciesItemWidget({required SpeciesModel speciesModel}) =>
      GetBuilder<CreatePostPageController>(
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

  Widget listBreedItemWidget() => GetBuilder<CreatePostPageController>(
        builder: (_) => Query(
          options: QueryOptions(
              document: gql(FETCH_BREED_BY_SPECIES_ID),
              variables: {
                "species_id": controller.selectedSpeciesId,
              }),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) {
            if (result.hasException) {
              return Text(result.exception.toString());
            } else if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (result.data != null) {
              controller.breedsMap[controller.selectedSpeciesId] =
                  BreedService.getBreedList(result.data!);

              // if (controller.selectedBreedMap[controller.selectedSpeciesId] ==
              //         null &&
              //     controller
              //         .breedsMap[controller.selectedSpeciesId]!.isNotEmpty) {
              //   controller.selectedBreedMap[controller.selectedSpeciesId] =
              //       controller.breedsMap[controller.selectedSpeciesId]![0].id;
              // }
              if (controller.selectedBreedMap[controller.selectedSpeciesId] ==
                  null) {
                controller.selectedBreedMap[controller.selectedSpeciesId] = -1;
              }
            }

            return controller.breedsMap[controller.selectedSpeciesId] != null &&
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
                  );
          },
        ),
      );

  Widget breedItemWidget({required BreedModel breedModel}) =>
      GetBuilder<CreatePostPageController>(
        builder: (_) => InkWell(
          onTap: () {
            controller.selectedBreedMap[controller.selectedSpeciesId]! ==
                    breedModel.id
                ? controller.selectedBreedMap[controller.selectedSpeciesId] = -1
                : controller.selectedBreedMap[controller.selectedSpeciesId] =
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
