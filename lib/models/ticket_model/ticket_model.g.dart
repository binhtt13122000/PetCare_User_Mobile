// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      cancelReason: json['cancelReason'] as String?,
      status: json['status'] as String,
      evidence: (json['media'] as List<dynamic>)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'type': instance.type,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'cancelReason': instance.cancelReason,
      'status': instance.status,
      'media': instance.evidence.map((e) => e.toJson()).toList(),
    };
