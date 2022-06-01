// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) =>
    ChatRoomModel(
      id: json['_id'] as String,
      sellerId: json['sellerId'] as int,
      buyerId: json['buyerId'] as int,
      postId: json['postId'] as int,
      newestMessageTime: DateTime.parse(json['newestMessageTime'] as String),
      newestMessage: json['newestMessage'] as String,
      isSellerMessage: json['isSellerMessage'] as bool,
      createdTime: DateTime.parse(json['createdTime'] as String),
      status: json['status'] as String,
      transactionTime: json['transactionTime'] == null
          ? null
          : DateTime.parse(json['transactionTime'] as String),
      transactionPlace: json['transactionPlace'] as String?,
      description: json['description'] as String?,
      transactionId: json['transactionId'] as int?,
      sellerLastViewTime: json['sellerLastViewTime'] == null
          ? null
          : DateTime.parse(json['sellerLastViewTime'] as String),
      buyerLastViewTime: json['buyerLastViewTime'] == null
          ? null
          : DateTime.parse(json['buyerLastViewTime'] as String),
      type: json['type'] as String,
    );

Map<String, dynamic> _$ChatRoomModelToJson(ChatRoomModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sellerId': instance.sellerId,
      'buyerId': instance.buyerId,
      'postId': instance.postId,
      'newestMessageTime': instance.newestMessageTime.toIso8601String(),
      'newestMessage': instance.newestMessage,
      'isSellerMessage': instance.isSellerMessage,
      'createdTime': instance.createdTime.toIso8601String(),
      'status': instance.status,
      'transactionTime': instance.transactionTime?.toIso8601String(),
      'transactionPlace': instance.transactionPlace,
      'description': instance.description,
      'transactionId': instance.transactionId,
      'sellerLastViewTime': instance.sellerLastViewTime?.toIso8601String(),
      'buyerLastViewTime': instance.buyerLastViewTime?.toIso8601String(),
      'type': instance.type,
    };
