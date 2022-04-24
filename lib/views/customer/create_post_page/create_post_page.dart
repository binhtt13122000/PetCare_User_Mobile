import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/breed.dart';
import 'package:petapp_mobile/graphql/query_mutation/pet.dart';
import 'package:petapp_mobile/graphql/query_mutation/species.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/services/breed_servies.dart';
import 'package:petapp_mobile/services/pet_services.dart';
import 'package:petapp_mobile/services/post_services.dart';
import 'package:petapp_mobile/services/species_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class CreatePostPage extends GetView<CreatePostPageController> {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignInPageController());
    SignInPageController signInPageController =
        Get.find<SignInPageController>();
    final accountId = 1;
    // signInPageController.accountModel!.id;

    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        extendBody: true,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              topWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      titleTextFieldWidget(),
                      descriptionTextFieldWidget(),
                      postTypeWidget(),
                      petFilterWidget(),
                      selectPetWidget(accountId: accountId),
                      pickImageGalleryButtonWidget(),
                      pickImageCameraButtonWidget(),
                      mediasWidget(),
                      receivedMoneyTextFieldWidget(),
                      const SizedBox(
                        height: 15,
                      ),
                      postPriceWidget(),
                      const SizedBox(
                        height: 10,
                      ),
                      depositWidget(),
                      const SizedBox(
                        height: 30,
                      ),
                      createPostButtonWidget(sellerId: accountId),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createPostButtonWidget({required int sellerId}) => Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: MaterialButton(
            height: 45,
            color: controller.title.value.isNotEmpty &&
                    controller.description.isNotEmpty
                ? PRIMARY_COLOR
                : PRIMARY_COLOR.withAlpha(130),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Post',
                  style: GoogleFonts.quicksand(
                    color: WHITE_COLOR,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  ICON_PATH + SEND_SVG,
                  color: WHITE_COLOR,
                  height: 18,
                ),
              ],
            ),
            onPressed: () {
              PostService.createPost(
                  title: controller.title.value,
                  price: controller.price.value,
                  deposit: controller.deposit.value,
                  refund: controller.moneyReceived.value,
                  effectiveTime: DateTime.now().add(const Duration(days: 30)),
                  description: controller.description.value,
                  type: controller.selectedTicketType.value,
                  petId: controller.selectedPetId.value,
                  sellerId: sellerId,
                  evidenceFilesPath: controller.evidencesPath,
                  healthCheckFilesPath: []);
            },
          ),
        ),
      );

  Widget topWidget() => Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //!back button
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: PRIMARY_LIGHT_COLOR,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ICON_PATH + BACK_SVG,
                  color: PRIMARY_COLOR,
                  height: 15,
                ),
              ),
            ),
            Text(
              'Create Post',
              style: GoogleFonts.satisfy(
                textStyle: const TextStyle(color: PRIMARY_COLOR),
                fontWeight: FontWeight.w700,
                fontSize: 25,
                height: 1,
              ),
            ),
          ],
        ),
      );

  Widget imageItemWidget({required int index}) => Obx(
        () => Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
              child: Image.file(
                controller.evidences[index],
                height: 180,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: InkWell(
                onTap: () => controller.evidences.removeAt(index),
                child: Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 167, 53, 255),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    'x',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                      color: WHITE_COLOR,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                width: 35,
                height: 25,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  (index + 1).toString() +
                      ' / ' +
                      controller.evidences.length.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                    color: const Color.fromARGB(255, 167, 53, 255),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget titleTextFieldWidget() => Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            cursorColor: PRIMARY_COLOR,
            initialValue: controller.title.value,
            maxLength: 40,
            decoration:
                controller.title.value.isEmpty && !controller.isFirstInputTitle
                    ? const InputDecoration(
                        labelText: 'Title',
                        errorText: 'The field title is required',
                        suffixIcon: Icon(
                          Icons.error,
                          color: Color.fromARGB(255, 241, 99, 88),
                          size: 20,
                        ),
                      )
                    : const InputDecoration(
                        labelText: 'Title',
                      ),
            onChanged: (String? value) {
              controller.title.value = value!;
              controller.isFirstInputTitle = false;
            },
          ),
        ),
      );

  Widget receivedMoneyTextFieldWidget() => Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            cursorColor: PRIMARY_COLOR,
            initialValue: controller.title.value,
            maxLength: 10,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: controller.moneyReceived.value.isEmpty &&
                    !controller.isFirstInputPrice
                ? InputDecoration(
                    labelText: 'Received money(vnđ)',
                    errorText: 'The field received money is required',
                    suffixIcon: const Icon(
                      Icons.error,
                      color: Color.fromARGB(255, 241, 99, 88),
                      size: 20,
                    ),
                    labelStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: LIGHT_GREY_COLOR,
                      fontSize: 16,
                    ),
                  )
                : InputDecoration(
                    labelText: 'Received money(vnđ)',
                    labelStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: LIGHT_GREY_COLOR,
                      fontSize: 16,
                    ),
                  ),
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w700,
              color: PRIMARY_COLOR,
              fontSize: 20,
            ),
            onChanged: (String? value) {
              controller.moneyReceived.value = value!;
              controller.isFirstInputPrice = false;
              if (int.tryParse(controller.moneyReceived.value) != null) {
                controller.price.value =
                    (int.parse(controller.moneyReceived.value) / 100 * 110)
                        .toInt();
                controller.deposit.value =
                    (int.parse(controller.moneyReceived.value) / 100 * 15)
                        .toInt();
              } else {
                controller.price.value = 0;
                controller.deposit.value = 0;
              }
            },
          ),
        ),
      );

  Widget descriptionTextFieldWidget() => Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            cursorColor: PRIMARY_COLOR,
            initialValue: controller.description.value,
            maxLength: 200,
            maxLines: 2,
            minLines: 2,
            decoration: controller.description.value.isEmpty &&
                    !controller.isFirstInputDescription
                ? const InputDecoration(
                    labelText: 'Description',
                    errorText: 'The field description is required',
                    suffixIcon: Icon(
                      Icons.error,
                      color: Color.fromARGB(255, 241, 99, 88),
                      size: 20,
                    ),
                  )
                : const InputDecoration(
                    labelText: 'Description',
                  ),
            onChanged: (String? value) {
              controller.description.value = value!;
              controller.isFirstInputDescription = false;
            },
          ),
        ),
      );

  Widget selectPetWidget({required int accountId}) => Padding(
        padding: const EdgeInsets.only(left: 40, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Select pet:',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: LIGHT_GREY_COLOR,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            MixinBuilder<CreatePostPageController>(builder: (_) {
              String query;
              Map<String, dynamic> variables;
              if (controller.isShowPetFilter.value) {
                if (controller.selectedBreedMap[
                            controller.selectedSpeciesId.value] ==
                        null ||
                    controller.selectedBreedMap[
                            controller.selectedSpeciesId.value]! ==
                        -1) {
                  query = FETCH_PET_LIST_WITHOUT_BREED_FOR_CREATE_POST;
                  variables = {
                    'accountId': accountId,
                    'speciesId': controller.selectedSpeciesId.value,
                  };
                } else {
                  query = FETCH_PET_LIST_WITH_BREED_FOR_CREATE_POST;
                  variables = {
                    'accountId': accountId,
                    'speciesId': controller.selectedSpeciesId.value,
                    'breedId': controller
                        .selectedBreedMap[controller.selectedSpeciesId.value],
                  };
                }
              } else {
                query = FETCH_PET_LIST_FOR_CREATE_POST;
                variables = {
                  'accountId': accountId,
                };
              }
              return Query(
                  options:
                      QueryOptions(document: gql(query), variables: variables),
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
                      controller.pets = PetService.getPetList(result.data!).obs;
                      if (controller.pets.isNotEmpty &&
                          (controller.isShowPetFilter.value ||
                              controller.isFirstSelectedPet)) {
                        controller.selectedPetId.value = controller.pets[0].id;
                        controller.isFirstSelectedPet = false;
                      }
                    }

                    return controller.pets.isNotEmpty
                        ? DropdownButton<String>(
                            icon: const SizedBox.shrink(),
                            itemHeight: 85,
                            value: controller.selectedPetId.value.toString(),
                            style: GoogleFonts.itim(
                              color: WHITE_COLOR,
                              fontSize: 20,
                            ),
                            underline: const SizedBox.shrink(),
                            onChanged: (String? value) {
                              controller.selectedPetId.value =
                                  int.parse(value!);
                            },
                            items: controller.pets
                                .asMap()
                                .entries
                                .map((e) => DropdownMenuItem(
                                      value: e.value.id.toString(),
                                      child: petItemWidget(petModel: e.value),
                                    ))
                                .toList(),
                          )
                        : Text(
                            'No suitable pet!',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 244, 55, 159),
                              fontSize: 16,
                            ),
                          );
                  });
            }),
          ],
        ),
      );

  Widget postPriceWidget() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Post price',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: LIGHT_GREY_COLOR,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.info_outline_rounded,
                  size: 15,
                  color: DARK_GREY_COLOR.withAlpha(100),
                ),
              ],
            ),
            Obx(
              () => Text(
                FORMAT_MONEY(price: controller.price.value),
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w700,
                  color: PRIMARY_COLOR,
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      );

  Widget depositWidget() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Buyer deposit',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: LIGHT_GREY_COLOR,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.info_outline_rounded,
                  size: 15,
                  color: DARK_GREY_COLOR.withAlpha(100),
                ),
              ],
            ),
            Obx(
              () => Text(
                FORMAT_MONEY(price: controller.deposit.value),
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w700,
                  color: PRIMARY_COLOR,
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      );

  Widget petItemWidget({required PetModel petModel}) => Container(
        height: 50,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: PRIMARY_COLOR),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20),
              ),
              child: Image.network(
                petModel.avatar,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 8,
              ),
              child: Text(petModel.name),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: WHITE_COLOR,
              size: 32,
            ),
          ],
        ),
      );

  Widget postTypeWidget() => Padding(
        padding: const EdgeInsets.only(left: 40, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Post type:',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: LIGHT_GREY_COLOR,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Obx(
              () => DropdownButton<String>(
                value: controller.selectedTicketType.value,
                style: GoogleFonts.itim(
                  color: PRIMARY_COLOR,
                  fontSize: 15,
                ),
                underline: Container(
                  height: 2,
                  color: PRIMARY_COLOR,
                ),
                onChanged: (String? value) {
                  controller.selectedTicketType.value = value!;
                },
                items: <String>['PURCHASE', 'BREEDING']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      );

  Widget pickImageGalleryButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: MaterialButton(
          color: PRIMARY_LIGHT_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pick post evidences from Gallery',
                style: GoogleFonts.quicksand(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                ICON_PATH + GALLERY_SVG,
                color: PRIMARY_COLOR,
                height: 23,
              ),
            ],
          ),
          onPressed: () {
            controller.pickImageFromGallery();
          },
        ),
      );

  Widget pickImageCameraButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: MaterialButton(
          color: PRIMARY_LIGHT_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pick post evidences from Camera',
                style: GoogleFonts.quicksand(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                ICON_PATH + CAMERA_SVG,
                color: PRIMARY_COLOR,
                height: 23,
              ),
            ],
          ),
          onPressed: () {
            controller.pickImageFromCamera();
          },
        ),
      );

  Widget mediasWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Obx(() {
          return controller.evidences.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 10,
                    children: controller.evidences
                        .asMap()
                        .entries
                        .map((e) => imageItemWidget(index: e.key))
                        .toList(),
                  ))
              : Container(
                  width: 250,
                  height: 180,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No medias have been selected yet',
                        style: GoogleFonts.itim(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: DARK_GREY_COLOR.withAlpha(90),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SvgPicture.asset(
                        ICON_PATH + NO_IMAGE_SVG,
                        color: DARK_GREY_COLOR.withAlpha(70),
                        height: 40,
                      ),
                    ],
                  ),
                );
        }),
      );

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
          }

          return Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(
              left: 60,
            ),
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
                  .map(
                    (e) => Obx(
                      () => Container(
                        width: 55 + e.value.name.length * 10,
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => controller.selectedSpeciesId.value ==
                                  e.value.id
                              ? null
                              : controller.selectedSpeciesId.value = e.value.id,
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: controller.selectedSpeciesId.value ==
                                      e.value.id
                                  ? PRIMARY_COLOR
                                  : PRIMARY_COLOR.withOpacity(0.13),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: controller.selectedSpeciesId.value ==
                                          e.value.id
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
                                  e.value.imageUrl!,
                                  height: 25,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  e.value.name,
                                  style: GoogleFonts.itim(
                                    color: e.value.id ==
                                            controller.selectedSpeciesId.value
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
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );

  Widget listBreedItemWidget() => Obx(
        () => Query(
          options: QueryOptions(
              document: gql(FETCH_BREED_BY_SPECIES_ID),
              variables: {
                "species_id": controller.selectedSpeciesId.value,
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
              controller.breedsMap[controller.selectedSpeciesId.value] =
                  BreedService.getBreedList(result.data!);

              if (controller
                      .selectedBreedMap[controller.selectedSpeciesId.value] ==
                  null) {
                controller
                    .selectedBreedMap[controller.selectedSpeciesId.value] = -1;
              }
            }

            return controller.breedsMap[controller.selectedSpeciesId.value] !=
                        null &&
                    controller.breedsMap[controller.selectedSpeciesId.value]!
                        .isNotEmpty
                ? Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                      left: 60,
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
                          .breedsMap[controller.selectedSpeciesId.value]!
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
            controller.selectedBreedMap[controller.selectedSpeciesId.value]! ==
                    breedModel.id
                ? controller
                    .selectedBreedMap[controller.selectedSpeciesId.value] = -1
                : controller
                        .selectedBreedMap[controller.selectedSpeciesId.value] =
                    breedModel.id;
            controller.update();
          },
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: controller.selectedBreedMap[
                              controller.selectedSpeciesId.value] !=
                          null &&
                      controller.selectedBreedMap[
                              controller.selectedSpeciesId.value]! ==
                          breedModel.id
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: controller.selectedBreedMap[
                                  controller.selectedSpeciesId.value] !=
                              null &&
                          controller.selectedBreedMap[
                                  controller.selectedSpeciesId.value]! ==
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
                color: controller.selectedBreedMap[
                                controller.selectedSpeciesId.value] !=
                            null &&
                        controller.selectedBreedMap[
                                controller.selectedSpeciesId.value] ==
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

  Widget petFilterWidget() => Column(
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: InkWell(
                    onTap: () => controller.isShowPetFilter.value =
                        !controller.isShowPetFilter.value,
                    child: Row(
                      children: [
                        Text(
                          'Pet filter',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: LIGHT_GREY_COLOR,
                            fontSize: 16,
                          ),
                        ),
                        Obx(
                          () => Icon(
                            controller.isShowPetFilter.value
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: controller.isShowPetFilter.value
                                ? PRIMARY_COLOR
                                : PRIMARY_COLOR.withAlpha(100),
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isShowPetFilter.value,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Text(
                        'Pet species',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: LIGHT_GREY_COLOR,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  listSpeciesWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Text(
                        'Pet breeds',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: LIGHT_GREY_COLOR,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  listBreedItemWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
