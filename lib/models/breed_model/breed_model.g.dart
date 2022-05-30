// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedModel _$BreedModelFromJson(Map<String, dynamic> json) => BreedModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      speciesModel: json['species'] == null
          ? null
          : SpeciesModel.fromJson(json['species'] as Map<String, dynamic>),
      speciesId: json['speciesId'] as int?,
    );

Map<String, dynamic> _$BreedModelToJson(BreedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'speciesId': instance.speciesId,
      'species': instance.speciesModel?.toJson(),
    };
