// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_combo_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesComboDetailModel _$ServicesComboDetailModelFromJson(
        Map<String, dynamic> json) =>
    ServicesComboDetailModel(
      id: json['id'] as int,
      priority: json['priority'] as int,
      nextEvent: json['nextEvent'] as int,
      isActive: json['isActive'] as bool,
      comboId: json['comboId'] as int,
      serviceId: json['serviceId'] as int,
      centerServiceModel:
          CenterServiceModel.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServicesComboDetailModelToJson(
        ServicesComboDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'priority': instance.priority,
      'nextEvent': instance.nextEvent,
      'isActive': instance.isActive,
      'comboId': instance.comboId,
      'serviceId': instance.serviceId,
      'service': instance.centerServiceModel.toJson(),
    };
