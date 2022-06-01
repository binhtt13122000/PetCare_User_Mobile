// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionModel _$PromotionModelFromJson(Map<String, dynamic> json) =>
    PromotionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      promo: json['promo'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      expireTime: DateTime.parse(json['expireTime'] as String),
      description: json['description'] as String?,
      status: json['status'] as String,
      applyMoney: json['applyMoney'] as int,
      maxMoneyPromo: json['maxMoneyPromo'] as int,
      point: json['point'] as int,
      branchId: json['branchId'] as int,
    );

Map<String, dynamic> _$PromotionModelToJson(PromotionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'promo': instance.promo,
      'startTime': instance.startTime.toIso8601String(),
      'expireTime': instance.expireTime.toIso8601String(),
      'description': instance.description,
      'status': instance.status,
      'applyMoney': instance.applyMoney,
      'maxMoneyPromo': instance.maxMoneyPromo,
      'point': instance.point,
      'branchId': instance.branchId,
    };
