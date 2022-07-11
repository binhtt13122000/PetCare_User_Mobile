// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
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
      star: json['star'] as int?,
      review: json['review'] as String?,
      branchModel: json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      orderDetailModelList: (json['orderDetails'] as List<dynamic>?)
          ?.map((e) => OrderDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      branchId: json['branchId'] as int,
      promotionId: json['promotionId'] as int?,
      customerId: json['customerId'] as int,
      registerTime: DateTime.parse(json['registerTime'] as String),
      promotionModel: json['promotion'] == null
          ? null
          : PromotionModel.fromJson(json['promotion'] as Map<String, dynamic>),
      cancelTime: json['cancelTime'] == null
          ? null
          : DateTime.parse(json['cancelTime'] as String),
      reasonCancel: json['reasonCancel'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
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
      'branchId': instance.branchId,
      'reasonCancel': instance.reasonCancel,
      'cancelTime': instance.cancelTime?.toIso8601String(),
      'promotionId': instance.promotionId,
      'customerId': instance.customerId,
      'registerTime': instance.registerTime.toIso8601String(),
      'branch': instance.branchModel?.toJson(),
      'orderDetails':
          instance.orderDetailModelList?.map((e) => e.toJson()).toList(),
      'promotion': instance.promotionModel?.toJson(),
    };
