import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';

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
  final String? vaccineDescription;
  @JsonKey(name: 'breed')
  final BreedModel breedModel;

  PetModel(
      {required this.id,
      required this.name,
      required this.avatar,
      this.description,
      this.color,
      required this.status,
      required this.breedModel,
      required this.dob,
      required this.gender,
      this.specialMarkings,
      this.vaccineDescription}) {
    var diff = DateTime.now().difference(dob);
    int dateAge = diff.inDays;
    if (dateAge > 365) {
      ageRange = '${dateAge ~/ 365} years\n'
          '${(dateAge - (dateAge ~/ 365) * 365) ~/ 30} months';
    } else {
      ageRange = '${dateAge ~/ 30} months';
    }
  }

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetModelToJson(this);
}
