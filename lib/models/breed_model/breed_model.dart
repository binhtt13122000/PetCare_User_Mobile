import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';

part 'breed_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BreedModel {
  final int id;
  final String name;
  final String? description;
  @JsonKey(name: 'species')
  final SpeciesModel? speciesModel;

  BreedModel(
      {required this.id,
      required this.name,
      this.description,
      required this.speciesModel});

  factory BreedModel.fromJson(Map<String, dynamic> json) =>
      _$BreedModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreedModelToJson(this);
}
