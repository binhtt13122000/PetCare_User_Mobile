import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';

part 'breed_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BreedModel {
  final int id;
  final String name;
  final String? description;
  final int? speciesId;
  @JsonKey(name: 'species')
  SpeciesModel? speciesModel;

  BreedModel({
    required this.id,
    required this.name,
    this.description,
    required this.speciesModel,
    this.speciesId,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) =>
      _$BreedModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreedModelToJson(this);
}
