import 'package:json_annotation/json_annotation.dart';

part 'vaccine_model.g.dart';

@JsonSerializable()
class VaccineModel {
  final int id;
  final String name;
  final String? description;
  final String origin;
  final bool isActive;

  VaccineModel({
    required this.id,
    required this.name,
    this.description,
    required this.origin,
    required this.isActive,
  });

  factory VaccineModel.fromJson(Map<String, dynamic> json) =>
      _$VaccineModelFromJson(json);

  Map<String, dynamic> toJson() => _$VaccineModelToJson(this);
}
