// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetModel _$PetModelFromJson(Map<String, dynamic> json) => PetModel(
      id: json['id'] as int,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      description: json['description'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      color: json['color'] as String?,
      status: json['status'] as String,
      breedModel: BreedModel.fromJson(json['breed'] as Map<String, dynamic>),
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$PetModelToJson(PetModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'description': instance.description,
      'gender': instance.gender,
      'bloodGroup': instance.bloodGroup,
      'color': instance.color,
      'status': instance.status,
      'dob': instance.dob?.toIso8601String(),
      'breed': instance.breedModel.toJson(),
    };
