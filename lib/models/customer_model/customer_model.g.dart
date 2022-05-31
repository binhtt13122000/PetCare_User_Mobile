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
      star: (json['star'] as num).toDouble(),
      point: json['point'] as int,
      numberFollowers: json['numberFollowers'] as int,
      numberReviewers: json['numberReviewers'] as int,
      email: json['email'] as String,
      bankName: json['bankName'] as String?,
      bankCode: json['bankCode'] as String?,
      bankBranch: json['bankBranch'] as String?,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'star': instance.star,
      'point': instance.point,
      'email': instance.email,
      'numberFollowers': instance.numberFollowers,
      'numberReviewers': instance.numberReviewers,
      'bankName': instance.bankName,
      'bankCode': instance.bankCode,
      'bankBranch': instance.bankBranch,
    };
