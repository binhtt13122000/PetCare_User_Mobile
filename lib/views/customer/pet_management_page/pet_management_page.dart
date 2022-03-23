import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';
//import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/graphql/query_mutation/pet.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';
import 'package:petapp_mobile/views/customer/pet_detail_page/pet_detail_page.dart';

class PetManagementPage extends GetView<PetManagementPageController> {
  const PetManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SignInPageController signInPageController = Get.find();
    return GraphQLProvider(
      client: controller.graphqlClient,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
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
                    //!app logo
                    Row(
                      children: [
                        SvgPicture.asset(
                          ICON_PATH + PET_LOGO_SVG,
                          color: PRIMARY_COLOR,
                          height: 29,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          'iU Petshop',
                          style: GoogleFonts.satisfy(
                            textStyle: const TextStyle(color: PRIMARY_COLOR),
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //!Title
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 0,
                ),
                child: Text(
                  'Pet Management',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                    fontSize: 40,
                    color: PRIMARY_COLOR,
                    height: 2,
                  ),
                ),
              ),
              //!Search bar
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  width: 300,
                  height: 50,
                  child: Material(
                    elevation: 5,
                    shadowColor: PRIMARY_COLOR,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        //searchItem = value;
                      },
                      decoration: InputDecoration(
                        isCollapsed: true,
                        prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 20,
                          ),
                          onPressed: () {
                            //onTapSearch(searchItem: searchItem);
                          },
                          color: PRIMARY_COLOR,
                        ),
                        hintText: 'Search pet by breed or name',
                        hintStyle: GoogleFonts.itim(
                          textStyle: const TextStyle(color: LIGHT_GREY_COLOR),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: WHITE_COLOR),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //!Table header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      'Avatar',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.itim(
                        fontSize: 18,
                        color: PRIMARY_COLOR,
                        height: 2,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 16,
                    child: Row(
                      children: controller.petManagementTableHeaders.entries
                          .map(
                            (e) => Expanded(
                              flex: e.key != 'Gender' ? 6 : 4,
                              child: InkWell(
                                onTap: () => controller.setHeaderFilter(e.key),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 22,
                                    ),
                                    Text(
                                      e.key,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.itim(
                                        fontSize: 18,
                                        color: PRIMARY_COLOR,
                                        height: 2,
                                      ),
                                    ),
                                    Obx(
                                      () => SvgPicture.asset(
                                        controller.petManagementTableHeaders[
                                                    e.key] ==
                                                2
                                            ? ICON_PATH + TOPWARD_ARROW_SVG
                                            : ICON_PATH + DOWNWARD_ARROW_SVG,
                                        color:
                                            controller.petManagementTableHeaders[
                                                        e.key] ==
                                                    0
                                                ? LIGHT_GREY_COLOR
                                                : const Color.fromARGB(
                                                    255, 244, 55, 165),
                                        height: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: PRIMARY_COLOR,
                ),
              ),
              Expanded(
                child: Query(
                  options: QueryOptions(
                      document: gql(FETCH_PET_LIST_BY_ACCOUNT_ID),
                      variables: {
                        //"_eq": signInPageController.accountID.value,
                        "_eq": 3,
                      }),
                  builder: (
                    QueryResult result, {
                    VoidCallback? refetch,
                    FetchMore? fetchMore,
                  }) {
                    if (result.hasException) {
                      return Text(result.exception.toString());
                    }
                    if (result.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    controller.pets = PetService.getPetList(result.data!).obs;
                    return SizedBox(
                      height: 320,
                      child: SingleChildScrollView(
                        child: Column(
                          children: controller.pets
                              .asMap()
                              .entries
                              .map(
                                (e) => petItemWidget(
                                    petModel: e.value,
                                    isLastIndex:
                                        e.key == (controller.pets.length - 1)),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //!button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  height: 40,
                  color: PRIMARY_LIGHT_COLOR,
                  child: InkWell(
                    onTap: () => Get.toNamed(ADD_PET_PAGE_ROUNTER),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add a new pet',
                          style: GoogleFonts.quicksand(
                            color: PRIMARY_COLOR,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          ICON_PATH + ADD_SVG,
                          color: PRIMARY_COLOR,
                          height: 23,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  height: 45,
                  color: PRIMARY_LIGHT_COLOR,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Management history',
                        style: GoogleFonts.quicksand(
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        ICON_PATH + HISTORY_SVG,
                        color: PRIMARY_COLOR,
                        height: 23,
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget petItemWidget(
          {required PetModel petModel, required bool isLastIndex}) =>
      Column(
        children: [
          InkWell(
            onTap: () => Get.to(() => PetDetaiPage(petModel: petModel)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(7),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(petModel.avatar),
                          fit: BoxFit.cover,
                          alignment: Alignment.center),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    petModel.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontSize: 17,
                      color: LIGHT_GREY_COLOR,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    petModel.breedModel.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontSize: 17,
                      color: LIGHT_GREY_COLOR,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SvgPicture.asset(
                    petModel.gender == 'MALE'
                        ? ICON_PATH + MALE_SVG
                        : ICON_PATH + FEMALE_SVG,
                    color: petModel.gender == 'MALE'
                        ? const Color.fromARGB(255, 55, 121, 244)
                        : const Color.fromARGB(255, 244, 55, 165),
                    height: petModel.gender == 'MALE' ? 19 : 23,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Visibility(
            visible: isLastIndex,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              color: DARK_GREY_COLOR.withAlpha(150),
              height: 0.5,
            ),
          ),
        ],
      );
}
