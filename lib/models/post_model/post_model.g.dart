// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as int,
      title: json['title'] as String?,
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      effectiveTime: json['effectiveTime'] == null
          ? null
          : DateTime.parse(json['effectiveTime'] as String),
      price: json['price'] as int?,
      deposit: json['deposit'] as int?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      petModel: json['pet'] == null
          ? null
          : PetModel.fromJson(json['pet'] as Map<String, dynamic>),
      mediaModels: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createTime': instance.createTime?.toIso8601String(),
      'effectiveTime': instance.effectiveTime?.toIso8601String(),
      'price': instance.price,
      'deposit': instance.deposit,
      'description': instance.description,
      'status': instance.status,
      'type': instance.type,
      'pet': instance.petModel?.toJson(),
      'media': instance.mediaModels?.map((e) => e.toJson()).toList(),
    };
