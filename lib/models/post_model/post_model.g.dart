// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as int,
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      provisionalTotal: json['provisionalTotal'] as int,
      description: json['description'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      petModel: json['pet'] == null
          ? null
          : PetModel.fromJson(json['pet'] as Map<String, dynamic>),
      mediaModels: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sellerReceive: json['sellerReceive'] as int,
      staffId: json['staffId'] as int?,
      reasonCancel: json['reasonCancel'] as String?,
      approveTime: json['approveTime'] == null
          ? null
          : DateTime.parse(json['approveTime'] as String),
      cancelTime: json['cancelTime'] == null
          ? null
          : DateTime.parse(json['cancelTime'] as String),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime?.toIso8601String(),
      'provisionalTotal': instance.provisionalTotal,
      'description': instance.description,
      'status': instance.status,
      'type': instance.type,
      'staffId': instance.staffId,
      'reasonCancel': instance.reasonCancel,
      'approveTime': instance.approveTime?.toIso8601String(),
      'cancelTime': instance.cancelTime?.toIso8601String(),
      'sellerReceive': instance.sellerReceive,
      'pet': instance.petModel?.toJson(),
      'media': instance.mediaModels?.map((e) => e.toJson()).toList(),
    };
