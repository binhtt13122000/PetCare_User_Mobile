// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_transaction_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalTransactionDetailModel _$NormalTransactionDetailModelFromJson(
        Map<String, dynamic> json) =>
    NormalTransactionDetailModel(
      id: json['id'] as int,
      price: json['price'] as int,
      description: json['description'] as String?,
      serviceModel:
          ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NormalTransactionDetailModelToJson(
        NormalTransactionDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'description': instance.description,
      'service': instance.serviceModel.toJson(),
    };
