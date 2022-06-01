import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceModel {
  final int id;
  final String name;
  final String? description;
  final String? healthCheckTemplate;
  final bool isHealthCheck;
  final bool status;
  final String unit;
  final int estimatedTime;

  ServiceModel({
    required this.id,
    required this.name,
    this.description,
    this.healthCheckTemplate,
    required this.isHealthCheck,
    required this.status,
    required this.unit,
    required this.estimatedTime,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
