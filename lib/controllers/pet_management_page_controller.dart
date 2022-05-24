// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

class PetManagementPageController extends GetxController {
  List<PetModel> petList = [];
  AccountModel accountModel = Get.find<SignInPageController>().accountModel!;
  RxBool isLoadingPetList = false.obs;

  PetManagementPageController() {
    selectedTicketType = postTypeList[0].obs;
  }
  // RxList<dynamic> images = List.empty(growable: true).obs;
  // ValueNotifier<GraphQLClient> graphqlClient = GRAPHQL_CLIENT;

  // late RxList<PetModel> pets;

  // final RxMap<String, int> petManagementTableHeaders = {
  //   'Name': 0,
  //   'Breed': 0,
  //   'Sex': 0,
  // }.obs;

  // setHeaderFilter(String headerKey) {
  //   petManagementTableHeaders.forEach((key, value) {
  //     if (key == headerKey) {
  //       if (value == 0 || value == 2) {
  //         petManagementTableHeaders[key] = 1;
  //         switch (headerKey) {
  //           case 'Name':
  //             break;
  //           case 'Breed':
  //             break;
  //           case 'Age':
  //             break;
  //           case 'Gender':
  //             break;
  //         }
  //       } else {
  //         petManagementTableHeaders[key] = 2;
  //         switch (headerKey) {
  //           case 'Name':
  //             break;
  //           case 'Breed':
  //             break;
  //           case 'Age':
  //             break;
  //           case 'Gender':
  //             break;
  //         }
  //       }
  //     } else {
  //       petManagementTableHeaders[key] = 0;
  //     }
  //   });
  // }

  final RxMap<String, int> postManagementTableHeaders = {
    'Title': 0,
    'Status': 0,
    'Create time': 0,
  }.obs;
  List<String> postTypeList = ['All status', 'Normal', 'In a post'];
  late RxString selectedTicketType;
  RxList<PostModel> postList = <PostModel>[].obs;

  setHeaderFilter(String headerKey) {
    postManagementTableHeaders.forEach((key, value) {
      if (key == headerKey) {
        if (value != 2) {
          postManagementTableHeaders[key] =
              postManagementTableHeaders[key]! + 1;
        } else {
          postManagementTableHeaders[key] = 0;
        }
      } else {
        postManagementTableHeaders[key] = 0;
      }
    });
  }
}
