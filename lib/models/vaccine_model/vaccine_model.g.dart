// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaccineModel _$VaccineModelFromJson(Map<String, dynamic> json) => VaccineModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      origin: json['origin'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$VaccineModelToJson(VaccineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'origin': instance.origin,
      'isActive': instance.isActive,
    };
