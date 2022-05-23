// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalTransactionModel _$NormalTransactionModelFromJson(
        Map<String, dynamic> json) =>
    NormalTransactionModel(
      id: json['id'] as int,
      description: json['description'] as String?,
      orderTotal: json['orderTotal'] as int,
      payment: json['payment'] as int?,
      paymentMethod: json['paymentMethod'] as String?,
      paymentTime: json['paymentTime'] == null
          ? null
          : DateTime.parse(json['paymentTime'] as String),
      point: json['point'] as int?,
      status: json['status'] as String,
      provisionalTotal: json['provisionalTotal'] as int,
      star: json['star'] as int,
      review: json['review'] as String?,
      branchModel: BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      normalTransactionDetailModelList: (json['order_details']
              as List<dynamic>?)
          ?.map((e) =>
              NormalTransactionDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NormalTransactionModelToJson(
        NormalTransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'orderTotal': instance.orderTotal,
      'payment': instance.payment,
      'paymentMethod': instance.paymentMethod,
      'paymentTime': instance.paymentTime?.toIso8601String(),
      'point': instance.point,
      'status': instance.status,
      'provisionalTotal': instance.provisionalTotal,
      'star': instance.star,
      'review': instance.review,
      'branch': instance.branchModel.toJson(),
      'order_details': instance.normalTransactionDetailModelList
          ?.map((e) => e.toJson())
          .toList(),
    };
