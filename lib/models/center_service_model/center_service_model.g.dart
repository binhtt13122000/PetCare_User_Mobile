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
      status: json['status'] as bool,
      unit: json['unit'] as String,
      estimatedTime: json['estimatedTime'] as int,
      centerServiceFeeModelList: (json['serviceFees'] as List<dynamic>?)
          ?.map(
              (e) => CenterServiceFeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
      speciesId: json['speciesId'] as int,
    );

Map<String, dynamic> _$CenterServiceModelToJson(CenterServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'unit': instance.unit,
      'estimatedTime': instance.estimatedTime,
      'type': instance.type,
      'speciesId': instance.speciesId,
      'serviceFees':
          instance.centerServiceFeeModelList?.map((e) => e.toJson()).toList(),
    };
