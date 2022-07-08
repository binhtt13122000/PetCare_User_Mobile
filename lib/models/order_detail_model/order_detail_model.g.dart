// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel(
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
      orderId: json['orderId'] as int?,
      centerServiceModel: json['service'] == null
          ? null
          : CenterServiceModel.fromJson(
              json['service'] as Map<String, dynamic>),
      breedTransactionId: json['breedTransactionId'] as int?,
      petComboModel: json['petCombo'] == null
          ? null
          : PetComboModel.fromJson(json['petCombo'] as Map<String, dynamic>),
      breedingTransactionModel: json['breedingTransaction'] == null
          ? null
          : BreedingTransactionModel.fromJson(
              json['breedingTransaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'serviceId': instance.serviceId,
      'description': instance.description,
      'price': instance.price,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
      'petComboId': instance.petComboId,
      'petId': instance.petId,
      'breedTransactionId': instance.breedTransactionId,
      'registerTime': instance.registerTime?.toIso8601String(),
      'petComboName': instance.petComboName,
      'service': instance.centerServiceModel?.toJson(),
      'petCombo': instance.petComboModel?.toJson(),
      'breedingTransaction': instance.breedingTransactionModel?.toJson(),
    };
