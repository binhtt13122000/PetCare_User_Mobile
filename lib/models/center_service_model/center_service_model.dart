import 'package:json_annotation/json_annotation.dart';

part 'center_service_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CenterServiceModel {
  final int id;
  final String name;
  final String? description;
  final String? healthCheckTemplate;
  final bool status;
  final String unit;
  final int estimatedTime;

  CenterServiceModel({
    required this.id,
    required this.name,
    this.description,
    this.healthCheckTemplate,
    required this.status,
    required this.unit,
    required this.estimatedTime,
  });

  factory CenterServiceModel.fromJson(Map<String, dynamic> json) =>
      _$CenterServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CenterServiceModelToJson(this);
}
