// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model_hasura.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModelHasura _$PostModelHasuraFromJson(Map<String, dynamic> json) =>
    PostModelHasura(
      branchId: json['branchId'] as int,
      cancelTime: json['cancelTime'] == null
          ? null
          : DateTime.parse(json['cancelTime'] as String),
      createTime: DateTime.parse(json['createTime'] as String),
      customerId: json['customerId'] as int,
      description: json['description'] as String?,
      id: json['id'] as int,
      meetingTime: json['meetingTime'] == null
          ? null
          : DateTime.parse(json['meetingTime'] as String),
      petId: json['petId'] as int,
      transactionTotal: json['transactionTotal'] as int,
      reasonCancel: json['reasonCancel'] as String?,
      reasonReject: json['reasonReject'] as String?,
      sellerReceive: json['sellerReceive'] as int,
      shopFee: json['shopFee'] as int,
      status: json['status'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      petModel: json['pet'] == null
          ? null
          : PetModel.fromJson(json['pet'] as Map<String, dynamic>),
      mediaModels: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      customerModel: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      branchModel: json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostModelHasuraToJson(PostModelHasura instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'cancelTime': instance.cancelTime?.toIso8601String(),
      'createTime': instance.createTime.toIso8601String(),
      'customerId': instance.customerId,
      'description': instance.description,
      'id': instance.id,
      'meetingTime': instance.meetingTime?.toIso8601String(),
      'petId': instance.petId,
      'transactionTotal': instance.transactionTotal,
      'reasonCancel': instance.reasonCancel,
      'reasonReject': instance.reasonReject,
      'sellerReceive': instance.sellerReceive,
      'shopFee': instance.shopFee,
      'status': instance.status,
      'title': instance.title,
      'type': instance.type,
      'pet': instance.petModel?.toJson(),
      'customer': instance.customerModel?.toJson(),
      'branch': instance.branchModel?.toJson(),
      'media': instance.mediaModels?.map((e) => e.toJson()).toList(),
    };
