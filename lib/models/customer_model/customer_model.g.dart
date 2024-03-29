// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      address: json['address'] as String?,
      gender: json['gender'] as String,
      avatar: json['avatar'] as String?,
      email: json['email'] as String,
      bankName: json['bankName'] as String?,
      bankCode: json['bankCode'] as String?,
      bankBranch: json['bankBranch'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      point: json['point'] as int,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'point': instance.point,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'bankName': instance.bankName,
      'bankCode': instance.bankCode,
      'bankBranch': instance.bankBranch,
    };
