// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_fees_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionFeesModel _$TransactionFeesModelFromJson(
        Map<String, dynamic> json) =>
    TransactionFeesModel(
      id: json['id'] as int,
      min: json['min'] as int,
      max: json['max'] as int,
      price: json['price'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$TransactionFeesModelToJson(
        TransactionFeesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'min': instance.min,
      'max': instance.max,
      'price': instance.price,
      'type': instance.type,
    };
