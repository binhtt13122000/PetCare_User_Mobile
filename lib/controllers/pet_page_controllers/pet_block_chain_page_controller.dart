import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_chain_model/pet_chain_model.dart';
import 'package:petapp_mobile/models/pet_chain_value_model/pet_chain_value_model.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class PetBlockChainPageController extends GetxController {
  late int petId;
  late String hashPetId;
  late int chainIndex;
  RxBool isWaitingLoadingData = false.obs;
  late PetChainModel? petChainModel;
  late PetModel petModel;
  late PetChainValueModel petChainValueModel;
  ScrollController scrollController = ScrollController();
  ScrollController detailScrollController = ScrollController();
  late int chainId;
  RxBool isShowTimelineTitle = false.obs;
  RxBool isShowFullId = false.obs;
  RxString selectedViewType = 'Pet details'.obs;
  List<String> viewTypes = [
    'Pet details',
    'Health records',
  ];

  PetBlockChainPageController() {
    scrollController.addListener(() {
      isShowTimelineTitle.value =
          scrollController.position.pixels > 155 ? true : false;
    });
  }
  late Map<String, List<PetHealthRecordModel>> petHealthRecordMap;
  late List<String> petHealthRecordMapKeyList;
  // late List<PetHealthRecordModel> vaccinesList;
  // late List<PetHealthRecordModel> dewormingList;
  // late List<PetHealthRecordModel> removeTicksList;

  // sortDewormingList() {
  //   dewormingList
  //       .sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  // }

  // sortVaccinesList() {
  //   vaccinesList.sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  // }

  // sortRemoveTicksList() {
  //   removeTicksList
  //       .sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  // }

  setListPetHealthRecord() {
    petHealthRecordMap = <String, List<PetHealthRecordModel>>{};
    petHealthRecordMapKeyList = [];
    for (var element in petChainValueModel
        .petChainValueContentModel.petModel.petHealthRecordModelList!) {
      if (petHealthRecordMapKeyList.contains(element.type)) {
        petHealthRecordMap[element.type]!.add(element);
      } else {
        petHealthRecordMapKeyList.add(element.type);
        petHealthRecordMap.addAll({
          element.type: [element]
        });
      }
    }
  }

  late Map<String, List<PetHealthRecordModel>> vaccinesMap;
  late List<String> vaccinesMapKeys;
  RxString selectedVaccine = 'All vaccines'.obs;
  RxBool isShowVaccinesList = false.obs;
  RxList<int> showDescriptionIndexList = <int>[].obs;

  setMapVaccines() {
    vaccinesMapKeys = ['All vaccines'];
    if (petHealthRecordMap['VACCINE'] != null) {
      vaccinesMap = {'All vaccines': petHealthRecordMap['VACCINE']!};
      for (var element in petHealthRecordMap['VACCINE']!) {
        if (vaccinesMapKeys.contains(element.vaccineModel!.name)) {
          vaccinesMap[element.vaccineModel!.name]!.add(element);
        } else {
          vaccinesMapKeys.add(element.vaccineModel!.name);
          List<PetHealthRecordModel> tmpVaccinesList = [element];
          vaccinesMap.addEntries(
              {MapEntry(element.vaccineModel!.name, tmpVaccinesList)});
        }
      }
    } else {
      vaccinesMap = {'All vaccines': []};
    }
  }

  sortMapVaccines() {
    vaccinesMap[selectedVaccine.value]!
        .sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  }
}
