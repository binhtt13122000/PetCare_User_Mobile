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
          serviceModel: json['service'] == null
              ? null
              : ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$CenterServicesTransactionDetailModelToJson(
        CenterServicesTransactionDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'description': instance.description,
      'service': instance.serviceModel?.toJson(),
    };
