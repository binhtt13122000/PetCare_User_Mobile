import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/weight_record_model/weight_record_model.dart';

class PetWeightPageController extends GetxController {
  late PetModel petModel;
  RxBool isLoadingData = false.obs;
  List<WeightRecordModel> recordsTime = [
    WeightRecordModel(
      recordTime: DateTime.now(),
      weight: 10,
    ),
    WeightRecordModel(
      recordTime: DateTime.now().add(const Duration(days: 13)),
      weight: 12,
    ),
    WeightRecordModel(
      recordTime: DateTime.now().add(const Duration(days: 24)),
      weight: 13,
    ),
    WeightRecordModel(
      recordTime: DateTime.now(),
      weight: 10,
    ),
    WeightRecordModel(
      recordTime: DateTime.now().add(const Duration(days: 33)),
      weight: 14,
    ),
    WeightRecordModel(
      recordTime: DateTime.now().add(const Duration(days: 49)),
      weight: 16,
    ),
    WeightRecordModel(
      recordTime: DateTime.now().add(const Duration(days: 60)),
      weight: 15.5,
    ),
  ];
}
