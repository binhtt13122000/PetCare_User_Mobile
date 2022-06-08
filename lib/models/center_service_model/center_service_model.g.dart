// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterServiceModel _$CenterServiceModelFromJson(Map<String, dynamic> json) =>
    CenterServiceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      healthCheckTemplate: json['healthCheckTemplate'] as String?,
      isHealthCheck: json['isHealthCheck'] as bool,
      status: json['status'] as bool,
      unit: json['unit'] as String,
      estimatedTime: json['estimatedTime'] as int,
    );

Map<String, dynamic> _$CenterServiceModelToJson(CenterServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'healthCheckTemplate': instance.healthCheckTemplate,
      'isHealthCheck': instance.isHealthCheck,
      'status': instance.status,
      'unit': instance.unit,
      'estimatedTime': instance.estimatedTime,
    };
