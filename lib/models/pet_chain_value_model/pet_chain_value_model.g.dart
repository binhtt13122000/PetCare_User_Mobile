// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_chain_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetChainValueModel _$PetChainValueModelFromJson(Map<String, dynamic> json) =>
    PetChainValueModel(
      date: json['date'] as String,
      type: json['type'] as String,
      txId: json['txId'] as String,
      petChainValueContentModel: PetChainValueContentModel.fromJson(
          json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PetChainValueModelToJson(PetChainValueModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'type': instance.type,
      'txId': instance.txId,
      'content': instance.petChainValueContentModel.toJson(),
    };
