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
      color: json['color'] as String?,
      status: json['status'] as String,
      breedModel: json['breed'] == null
          ? null
          : BreedModel.fromJson(json['breed'] as Map<String, dynamic>),
      dob: DateTime.parse(json['dob'] as String),
      gender: json['gender'] as String,
      specialMarkings: json['specialMarkings'] as String?,
      breedId: json['breedId'] as int?,
      isFertility: json['isSeed'] as bool,
      petHealthRecordModelList: (json['healthPetRecords'] as List<dynamic>?)
          ?.map((e) => PetHealthRecordModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      petOwnerModelList: (json['petOwners'] as List<dynamic>?)
          ?.map((e) => PetOwnerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PetModelToJson(PetModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'description': instance.description,
      'gender': instance.gender,
      'color': instance.color,
      'status': instance.status,
      'dob': instance.dob.toIso8601String(),
      'specialMarkings': instance.specialMarkings,
      'breedId': instance.breedId,
      'isSeed': instance.isFertility,
      'breed': instance.breedModel?.toJson(),
      'healthPetRecords':
          instance.petHealthRecordModelList?.map((e) => e.toJson()).toList(),
      'petOwners': instance.petOwnerModelList?.map((e) => e.toJson()).toList(),
    };
