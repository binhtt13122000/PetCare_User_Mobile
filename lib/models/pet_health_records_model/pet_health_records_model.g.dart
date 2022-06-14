// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_health_records_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetHealthRecordModel _$PetHealthRecordModelFromJson(
        Map<String, dynamic> json) =>
    PetHealthRecordModel(
      id: json['id'] as int,
      dateOfInjection: DateTime.parse(json['dateOfInjection'] as String),
      description: json['description'] as String?,
      vaccineType: json['vaccineType'] as String,
      type: json['type'] as String,
      vaccineId: json['vaccineId'] as int?,
      petId: json['petId'] as int,
      branchId: json['branchId'] as int,
      vaccineModel: json['vaccine'] == null
          ? null
          : VaccineModel.fromJson(json['vaccine'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PetHealthRecordModelToJson(
        PetHealthRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateOfInjection': instance.dateOfInjection.toIso8601String(),
      'description': instance.description,
      'vaccineType': instance.vaccineType,
      'type': instance.type,
      'vaccineId': instance.vaccineId,
      'petId': instance.petId,
      'vaccine': instance.vaccineModel,
      'branchId': instance.branchId,
    };
