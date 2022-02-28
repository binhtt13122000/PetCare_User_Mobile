import 'package:get/get.dart';
import 'package:petapp_mobile/models/purchase_post/purchase_post.dart';

import '../configs/path.dart';
import '../models/services/services.dart';

class HomeController extends GetxController {
  late RxInt selectedServiceIndex;
  List<Service> services = List.empty(growable: true);
  List<PurchasePost> purchasePosts = List.empty(growable: true);

  HomeController() {
    services.add(
      Service(
          id: 1,
          name: 'Purchase',
          imageUrl: IMAGE_PATH + HAND_SHAKE_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      Service(
          id: 2,
          name: 'Veterinary',
          imageUrl: IMAGE_PATH + VERTERINARIAN_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      Service(
          id: 3,
          name: 'Grooming',
          imageUrl: IMAGE_PATH + GROOMING_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      Service(
          id: 4,
          name: 'Breeding',
          imageUrl: IMAGE_PATH + PET_BABY_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      Service(
          id: 5,
          name: 'Traning',
          imageUrl: IMAGE_PATH + TRANING_PNG,
          description: 'description',
          status: 1),
    );

    selectedServiceIndex = services[0].id.obs;

    purchasePosts.add(
      PurchasePost(
          id: 1,
          title: 'I have a 12 month old gray husky for sale, please buy thank',
          breed: 'Golden',
          petImage: [
            'https://i.pinimg.com/564x/ff/4e/e4/ff4ee42d75b015ee5f286427feecd339.jpg'
          ],
          price: 15000000,
          percentDiscount: 5),
    );
    purchasePosts.add(
      PurchasePost(
          id: 2,
          title: 'Hello! My pet is so cute, you see. Please buy, thank',
          breed: 'Husky',
          isMale: false,
          petImage: [
            'https://i.pinimg.com/564x/2c/e9/31/2ce931c901ba679c2a855bfd77e6da5f.jpg'
          ],
          price: 35600000,
          percentDiscount: 10,
          age: 3),
    );
    purchasePosts.add(
      PurchasePost(
          id: 3,
          title: 'I have a 12 month old gray husky for sale, please buy thank',
          breed: 'Wirehair',
          petImage: [
            'https://i.pinimg.com/564x/17/61/cb/1761cbcffc03a7c887dc37bd58c58690.jpg'
          ],
          price: 15000000,
          percentDiscount: 15),
    );
    purchasePosts.add(
      PurchasePost(
          id: 4,
          title: 'I have a 12 month old gray husky for sale, please buy thank',
          breed: 'Birman',
          petImage: [
            'https://i.pinimg.com/564x/ff/72/2c/ff722cb5c4746841a67fd6501817e9da.jpg'
          ],
          price: 15000000,
          percentDiscount: 20),
    );
  }
}
