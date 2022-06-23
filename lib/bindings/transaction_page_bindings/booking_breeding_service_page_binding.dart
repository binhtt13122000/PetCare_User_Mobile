import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/booking_breeding_service_page_controller.dart';

class BookingBreedingServicesPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingBreedingServicesPageController>(
        () => BookingBreedingServicesPageController());
  }
}
