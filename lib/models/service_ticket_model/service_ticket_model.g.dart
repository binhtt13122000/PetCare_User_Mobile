// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceTicketModel _$ServiceTicketModelFromJson(Map<String, dynamic> json) =>
    ServiceTicketModel(
      id: json['id'] as int?,
      serviceId: json['serviceId'] as int,
      ticketId: json['ticketId'] as int?,
      centerServiceModel: json['service'] == null
          ? null
          : CenterServiceModel.fromJson(
              json['service'] as Map<String, dynamic>),
      petId: json['petId'] as int,
    );

Map<String, dynamic> _$ServiceTicketModelToJson(ServiceTicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceId': instance.serviceId,
      'ticketId': instance.ticketId,
      'petId': instance.petId,
      'service': instance.centerServiceModel?.toJson(),
    };
