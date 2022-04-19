import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/models/services_model/services_model.dart';

class HomePageController extends GetxController {
  late RxInt selectedServiceIndex;
  List<ServiceModel> services = List.empty(growable: true);
  //List<PurchasePostModel> purchasePosts = List.empty(growable: true);
  late List<PostModel> postList;

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
          name: 'Veterinary',
          imageUrl: IMAGE_PATH + VERTERINARIAN_PNG,
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
          name: 'Traning',
          imageUrl: IMAGE_PATH + TRANING_PNG,
          description: 'description',
          status: 1),
    );

    selectedServiceIndex = services[0].id.obs;
  }
}
