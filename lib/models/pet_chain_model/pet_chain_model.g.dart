// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_chain_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetChainModel _$PetChainModelFromJson(Map<String, dynamic> json) =>
    PetChainModel(
      key: json['key'] as String,
      valueModelList: (json['value'] as List<dynamic>)
          .map((e) => PetChainValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PetChainModelToJson(PetChainModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.valueModelList.map((e) => e.toJson()).toList(),
    };
