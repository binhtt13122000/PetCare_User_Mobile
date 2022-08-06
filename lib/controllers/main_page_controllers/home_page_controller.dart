import 'package:get/get.dart';
import 'package:petapp_mobile/configs/enum_config.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/models/services_model/services_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageController extends GetxController {
  RxBool isLoadingData = false.obs;
  String loadingType = LoadingType.INIT.name;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxBool isWaitingLoadingBranchList = false.obs;
  late List<BranchModel> branchModelList;
  RxList<String> selectedBranchList = <String>[].obs;

  RxBool isWaitingLoadingServicesList = false.obs;
  late List<CenterServiceModel> servicesList;
  RxList<String> selectedServicesList = <String>[].obs;

  AccountModel accountModel = Get.find<AuthController>().accountModel;
  late RxInt selectedServiceIndex;
  List<ServiceModel> services = List.empty(growable: true);
  List<PostModel> postList = List.empty(growable: true);
  RxBool isWaitingLoadingPostList = false.obs;
  HomePageController() {
    services.add(
      ServiceModel(
          id: 1,
          name: 'Purchase',
          imageUrl: IMAGE_PATH + HAND_SHAKE_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 2,
          name: 'Center',
          imageUrl: IMAGE_PATH + VETERINARIAN_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 3,
          name: 'Services',
          imageUrl: IMAGE_PATH + GROOMING_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 4,
          name: 'Combo',
          imageUrl: IMAGE_PATH + PET_BABY_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 5,
          name: 'Scan QR',
          imageUrl: IMAGE_PATH + QR_PNG,
          description: 'description',
          status: 1),
    );

    selectedServiceIndex = services[0].id.obs;
  }
}
