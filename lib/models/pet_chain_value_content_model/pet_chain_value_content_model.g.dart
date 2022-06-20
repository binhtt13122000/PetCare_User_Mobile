// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_chain_value_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetChainValueContentModel _$PetChainValueContentModelFromJson(
        Map<String, dynamic> json) =>
    PetChainValueContentModel(
      write: json['write'] as String,
      petModel: PetModel.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PetChainValueContentModelToJson(
        PetChainValueContentModel instance) =>
    <String, dynamic>{
      'write': instance.write,
      'current': instance.petModel.toJson(),
    };
