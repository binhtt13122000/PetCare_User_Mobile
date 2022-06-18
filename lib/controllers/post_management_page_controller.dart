import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

class PostManagementPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;

  TextEditingController textEditingController = TextEditingController();
  RxString searchText = ''.obs;

  RxBool isLoadingPostList = false.obs;
  final RxMap<String, int> postManagementTableHeaders = {
    'Title': 0,
    'Status': 0,
    'Create time': 0,
  }.obs;
  List<String> postTypeList = ['All type', 'Sale', 'Breed'];
  late RxString selectPostType;
  List<PostModel> postList = <PostModel>[].obs;

  PostManagementPageController() {
    selectPostType = postTypeList[0].obs;
  }
}
