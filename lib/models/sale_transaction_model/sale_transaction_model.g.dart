// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleTransactionModel _$SaleTransactionModelFromJson(
        Map<String, dynamic> json) =>
    SaleTransactionModel(
      createdTime: DateTime.parse(json['createdTime'] as String),
      description: json['description'] as String?,
      id: json['id'] as int,
      meetingTime: DateTime.parse(json['meetingTime'] as String),
      paymentMethod: json['paymentMethod'] as String?,
      petId: json['petId'] as int,
      placeMeeting: json['placeMeeting'] as String,
      postId: json['postId'] as int,
      review: json['review'] as String?,
      reasonCancel: json['reasonCancel'] as String?,
      sellerId: json['sellerId'] as int,
      star: json['star'] as int?,
      status: json['status'] as String,
      transactionTime: json['transactionTime'] == null
          ? null
          : DateTime.parse(json['transactionTime'] as String),
      postModel: json['post'] == null
          ? null
          : PostModel.fromJson(json['post'] as Map<String, dynamic>),
      petModel: json['pet'] == null
          ? null
          : PetModel.fromJson(json['pet'] as Map<String, dynamic>),
      buyerCustomerModel:
          CustomerModel.fromJson(json['buyer'] as Map<String, dynamic>),
      sellerCustomerModel:
          CustomerModel.fromJson(json['seller'] as Map<String, dynamic>),
      buyerId: json['buyerId'] as int,
      point: json['point'] as int?,
      cancelTime: json['cancelTime'] == null
          ? null
          : DateTime.parse(json['cancelTime'] as String),
    );

Map<String, dynamic> _$SaleTransactionModelToJson(
        SaleTransactionModel instance) =>
    <String, dynamic>{
      'createdTime': instance.createdTime.toIso8601String(),
      'description': instance.description,
      'id': instance.id,
      'meetingTime': instance.meetingTime.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'petId': instance.petId,
      'placeMeeting': instance.placeMeeting,
      'postId': instance.postId,
      'review': instance.review,
      'reasonCancel': instance.reasonCancel,
      'sellerId': instance.sellerId,
      'star': instance.star,
      'status': instance.status,
      'transactionTime': instance.transactionTime?.toIso8601String(),
      'buyerId': instance.buyerId,
      'point': instance.point,
      'cancelTime': instance.cancelTime?.toIso8601String(),
      'post': instance.postModel?.toJson(),
      'pet': instance.petModel?.toJson(),
      'buyer': instance.buyerCustomerModel.toJson(),
      'seller': instance.sellerCustomerModel.toJson(),
    };
