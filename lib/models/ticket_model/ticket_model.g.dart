// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: json['id'] as int,
      createdTime: DateTime.parse(json['createdTime'] as String),
      meetingDate: DateTime.parse(json['meetingDate'] as String),
      startTime: json['startTime'] as int?,
      endTime: json['endTime'] as int?,
      branchId: json['branchId'] as int,
      customerId: json['customerId'] as int,
      status: json['status'] as String,
      serviceTicketModelList: (json['serviceTickets'] as List<dynamic>?)
          ?.map((e) => ServiceTicketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdTime': instance.createdTime.toIso8601String(),
      'meetingDate': instance.meetingDate.toIso8601String(),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'branchId': instance.branchId,
      'customerId': instance.customerId,
      'status': instance.status,
      'serviceTickets':
          instance.serviceTicketModelList?.map((e) => e.toJson()).toList(),
    };
