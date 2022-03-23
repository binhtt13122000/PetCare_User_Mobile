import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';

part 'pet_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PetModel {
  final int id;
  final String name;
  final String avatar;
  final int ageRange;
  final String? description;
  final String gender;
  final String? bloodGroup;
  final String? color;
  final String status;
  final DateTime? dob;
  @JsonKey(name: 'category')
  final BreedModel breedModel;

  PetModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.ageRange,
    this.description,
    this.bloodGroup,
    this.color,
    required this.status,
    required this.breedModel,
    this.dob,
    required this.gender,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetModelToJson(this);
}
