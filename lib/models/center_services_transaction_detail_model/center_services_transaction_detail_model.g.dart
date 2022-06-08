// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_services_transaction_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CenterServicesTransactionDetailModel
    _$CenterServicesTransactionDetailModelFromJson(Map<String, dynamic> json) =>
        CenterServicesTransactionDetailModel(
          id: json['id'] as int,
          price: json['price'] as int,
          description: json['description'] as String?,
          centerServiceModel: CenterServiceModel.fromJson(
              json['service'] as Map<String, dynamic>),
          quantity: json['quantity'] as int,
          serviceId: json['serviceId'] as int,
          totalPrice: json['totalPrice'] as int,
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
      'service': instance.centerServiceModel.toJson(),
    };
