import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

class PostManagementPageController extends GetxController {
  ValueNotifier<GraphQLClient> graphqlClient = GRAPHQL_CLIENT;
  final RxMap<String, int> postManagementTableHeaders = {
    'Title': 0,
    'Status': 0,
    'Create time': 0,
  }.obs;
  List<String> postTypeList = ['All Type', 'PURCHASE', 'BREEDING'];
  late RxString selectedTicketType;
  RxList<PostModel> postList = <PostModel>[].obs;

  PostManagementPageController() {
    selectedTicketType = postTypeList[0].obs;
  }
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
