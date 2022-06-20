// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_owner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetOwnerModel _$PetOwnerModelFromJson(Map<String, dynamic> json) =>
    PetOwnerModel(
      id: json['id'] as int,
      isCurrentOwner: json['isCurrentOwner'] as bool,
      date: DateTime.parse(json['date'] as String),
      petId: json['petId'] as int,
      customerId: json['customerId'] as int,
      customerModel:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PetOwnerModelToJson(PetOwnerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isCurrentOwner': instance.isCurrentOwner,
      'date': instance.date.toIso8601String(),
      'petId': instance.petId,
      'customerId': instance.customerId,
      'customer': instance.customerModel,
    };
