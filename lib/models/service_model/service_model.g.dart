// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String?,
      healthCheckTemplate: json['healthCheckTemplate'] as String?,
      isHealthCheck: json['isHealthCheck'] as bool,
      status: json['status'] as bool,
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'healthCheckTemplate': instance.healthCheckTemplate,
      'isHealthCheck': instance.isHealthCheck,
      'status': instance.status,
      'unit': instance.unit,
    };