// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      isSellerMessage: json['isSellerMessage'] as bool,
      content: json['content'] as String,
      type: json['type'] as String,
      createdTime: DateTime.parse(json['createdTime'] as String),
      room: json['room'] as String?,
      buyerId: json['buyerId'] as int?,
      postId: json['postId'] as int?,
      sellerId: json['sellerId'] as int?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'isSellerMessage': instance.isSellerMessage,
      'content': instance.content,
      'type': instance.type,
      'createdTime': instance.createdTime.toIso8601String(),
      'room': instance.room,
      'buyerId': instance.buyerId,
      'postId': instance.postId,
      'sellerId': instance.sellerId,
    };
