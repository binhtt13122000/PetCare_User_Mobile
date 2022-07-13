import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';
import 'package:petapp_mobile/models/pet_owner_model/pet_owner_model.dart';

part 'pet_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PetModel {
  final int id;
  final String name;
  final String avatar;
  @JsonKey(ignore: true)
  late String ageRange;
  final String? description;
  final String gender;
  final String? color;
  final String status;
  final DateTime dob;
  final String? specialMarkings;
  final int? breedId;
  @JsonKey(name: 'isSeed')
  final bool isFertility;
  @JsonKey(name: 'breed')
  BreedModel? breedModel;
  @JsonKey(name: 'healthPetRecords')
  final List<PetHealthRecordModel>? petHealthRecordModelList;
  @JsonKey(name: 'petOwners')
  final List<PetOwnerModel>? petOwnerModelList;
  @JsonKey(ignore: true)
  PetOwnerModel? currentPetOwner;

  PetModel({
    required this.id,
    required this.name,
    required this.avatar,
    this.description,
    this.color,
    required this.status,
    required this.breedModel,
    required this.dob,
    required this.gender,
    this.specialMarkings,
    this.breedId,
    required this.isFertility,
    this.petHealthRecordModelList,
    this.petOwnerModelList,
  }) {
    var diff = DateTime.now().difference(dob);
    int dateAge = diff.inDays;
    if (dateAge > 365) {
      ageRange = '${dateAge ~/ 365} years\n'
          '${(dateAge - (dateAge ~/ 365) * 365) ~/ 30} months';
    } else {
      ageRange = '${dateAge ~/ 30} months';
    }
    if (petOwnerModelList != null) {
      for (var element in petOwnerModelList!) {
        if (element.isCurrentOwner == true) {
          currentPetOwner = element;
          break;
        }
      }
    }
  }

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetModelToJson(this);
}
