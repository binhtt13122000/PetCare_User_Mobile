// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleTransactionModel _$SaleTransactionModelFromJson(
        Map<String, dynamic> json) =>
    SaleTransactionModel(
      id: json['id'] as int,
      description: json['description'] as String?,
      buyerId: json['buyerId'] as int,
      deposit: json['deposit'] as int,
      payForSeller: json['payForSeller'] as int,
      payForSellerTime: json['payForSellerTime'] == null
          ? null
          : DateTime.parse(json['payForSellerTime'] as String),
      payFromBuyerTime: json['payFromBuyerTime'] == null
          ? null
          : DateTime.parse(json['payFromBuyerTime'] as String),
      reasonCancel: json['reasonCancel'] as String?,
      sellerId: json['sellerId'] as int,
      totalPrice: json['totalPrice'] as int,
      status: json['status'] as String,
      mediaModelsForBuyer: (json['media'] as List<dynamic>)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      postModel: PostModel.fromJson(json['post'] as Map<String, dynamic>),
      createTime: DateTime.parse(json['createTime'] as String),
      mediaModelsForSeller:
          (json['mediaBySaletransactionsellercontractid'] as List<dynamic>)
              .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SaleTransactionModelToJson(
        SaleTransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'buyerId': instance.buyerId,
      'deposit': instance.deposit,
      'payForSeller': instance.payForSeller,
      'payForSellerTime': instance.payForSellerTime?.toIso8601String(),
      'payFromBuyerTime': instance.payFromBuyerTime?.toIso8601String(),
      'reasonCancel': instance.reasonCancel,
      'sellerId': instance.sellerId,
      'totalPrice': instance.totalPrice,
      'status': instance.status,
      'createTime': instance.createTime.toIso8601String(),
      'media': instance.mediaModelsForBuyer.map((e) => e.toJson()).toList(),
      'mediaBySaletransactionsellercontractid':
          instance.mediaModelsForSeller.map((e) => e.toJson()).toList(),
      'post': instance.postModel.toJson(),
    };
