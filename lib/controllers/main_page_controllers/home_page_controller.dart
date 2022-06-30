import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/models/services_model/services_model.dart';

class HomePageController extends GetxController {
  RxBool isWaitingLoadingBranchList = false.obs;
  late List<BranchModel> branchModelList;
  RxList<String> selectedBranch = <String>[].obs;

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
          name: 'Grooming',
          imageUrl: IMAGE_PATH + GROOMING_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 4,
          name: 'Breeding',
          imageUrl: IMAGE_PATH + PET_BABY_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 5,
          name: 'Training',
          imageUrl: IMAGE_PATH + TRAINING_PNG,
          description: 'description',
          status: 1),
    );

    selectedServiceIndex = services[0].id.obs;
  }
}
