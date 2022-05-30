import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

class PostManagementPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;

  RxBool isLoadingPostList = false.obs;
  final RxMap<String, int> postManagementTableHeaders = {
    'Title': 0,
    'Status': 0,
    'Create time': 0,
  }.obs;
  List<String> postTypeList = ['All type', 'Purchase', 'Breeding'];
  late RxString selectedTicketType;
  List<PostModel> postList = <PostModel>[].obs;

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
