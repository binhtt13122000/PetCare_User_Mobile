// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_services_transaction_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterServicesTransactionDetailModel
    _$CenterServicesTransactionDetailModelFromJson(Map<String, dynamic> json) =>
        CenterServicesTransactionDetailModel(
          id: json['id'] as int?,
          price: json['price'] as int,
          description: json['description'] as String?,
          quantity: json['quantity'] as int,
          totalPrice: json['totalPrice'] as int,
          serviceId: json['serviceId'] as int?,
          petId: json['petId'] as int?,
          registerTime: json['registerTime'] == null
              ? null
              : DateTime.parse(json['registerTime'] as String),
          petComboId: json['petComboId'] as int?,
          petComboName: json['petComboName'] as String?,
          centerServicesTransactionId: json['orderId'] as int?,
          centerServiceModel: json['service'] == null
              ? null
              : CenterServiceModel.fromJson(
                  json['service'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$CenterServicesTransactionDetailModelToJson(
        CenterServicesTransactionDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'description': instance.description,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
      'serviceId': instance.serviceId,
      'petId': instance.petId,
      'registerTime': instance.registerTime?.toIso8601String(),
      'petComboId': instance.petComboId,
      'petComboName': instance.petComboName,
      'orderId': instance.centerServicesTransactionId,
      'service': instance.centerServiceModel?.toJson(),
    };
