// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      id: json['id'] as int,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      roleId: json['roleId'] as int,
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      // 'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'roleId': instance.roleId,
    };
