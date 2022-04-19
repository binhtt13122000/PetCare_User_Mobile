// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      id: json['id'] as int,
      email: json['email'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String?,
      registerTime: DateTime.parse(json['registerTime'] as String),
      isActive: json['isActive'] as bool,
      roleId: json['roleId'] as int,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'registerTime': instance.registerTime.toIso8601String(),
      'isActive': instance.isActive,
      'roleId': instance.roleId,
      'dob': instance.dob?.toIso8601String(),
    };
