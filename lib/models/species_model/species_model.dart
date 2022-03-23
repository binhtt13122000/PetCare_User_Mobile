import 'package:json_annotation/json_annotation.dart';

part 'species_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SpeciesModel {
  final int id;
  final String name;
  String? imageUrl;
  final String? description;
  final bool isBreeding;

  SpeciesModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.isBreeding,
  });

  factory SpeciesModel.fromJson(Map<String, dynamic> json) =>
      _$SpeciesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpeciesModelToJson(this);
}
