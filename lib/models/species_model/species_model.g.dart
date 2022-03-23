// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeciesModel _$SpeciesModelFromJson(Map<String, dynamic> json) => SpeciesModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isBreeding: json['isBreeding'] as bool,
    );

Map<String, dynamic> _$SpeciesModelToJson(SpeciesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'isBreeding': instance.isBreeding,
    };
