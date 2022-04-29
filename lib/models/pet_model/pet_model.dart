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
  final String? bloodGroup;
  final String? color;
  final String status;
  final DateTime? dob;
  @JsonKey(name: 'breed')
  final BreedModel breedModel;

  PetModel({
    required this.id,
    required this.name,
    required this.avatar,
    this.description,
    this.bloodGroup,
    this.color,
    required this.status,
    required this.breedModel,
    this.dob,
    required this.gender,
  }) {
    ageRange = '123';
  }

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetModelToJson(this);
}
