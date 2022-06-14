// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_combo_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetComboDetailModel _$PetComboDetailModelFromJson(Map<String, dynamic> json) =>
    PetComboDetailModel(
      id: json['id'] as int,
      workingTime: DateTime.parse(json['workingTime'] as String),
      isCompleted: json['isCompleted'] as bool,
      serviceId: json['serviceId'] as int,
      petComboId: json['petComboId'] as int,
      realTime: json['realTime'] == null
          ? null
          : DateTime.parse(json['realTime'] as String),
      priority: json['priority'] as int?,
      star: json['star'] as int?,
      review: json['review'] as String?,
      centerServiceModel:
          CenterServiceModel.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PetComboDetailModelToJson(
        PetComboDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workingTime': instance.workingTime.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'serviceId': instance.serviceId,
      'petComboId': instance.petComboId,
      'realTime': instance.realTime?.toIso8601String(),
      'priority': instance.priority,
      'star': instance.star,
      'review': instance.review,
      'service': instance.centerServiceModel.toJson(),
    };
