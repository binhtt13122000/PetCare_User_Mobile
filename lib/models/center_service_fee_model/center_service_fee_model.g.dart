// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_service_fee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterServiceFeeModel _$CenterServiceFeeModelFromJson(
        Map<String, dynamic> json) =>
    CenterServiceFeeModel(
      id: json['id'] as int,
      mix: json['mix'] as int?,
      max: json['max'] as int?,
      price: json['price'] as int,
    );

Map<String, dynamic> _$CenterServiceFeeModelToJson(
        CenterServiceFeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mix': instance.mix,
      'max': instance.max,
      'price': instance.price,
    };
