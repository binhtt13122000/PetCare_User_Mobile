import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/service_ticket_model/service_ticket_model.dart';

part 'ticket_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TicketModel {
  final int id;
  final DateTime createdTime;
  final DateTime meetingDate;
  int? startTime;
  int? endTime;
  final int branchId;
  final int customerId;
  final String status;
  // @JsonKey(ignore: true)
  // int totalEstimateTime = 0;
  @JsonKey(name: 'serviceTickets')
  final List<ServiceTicketModel>? serviceTicketModelList;

  TicketModel({
    required this.id,
    required this.createdTime,
    required this.meetingDate,
    this.startTime,
    this.endTime,
    required this.branchId,
    required this.customerId,
    required this.status,
    required this.serviceTicketModelList,
  }) {
    // for (var element in serviceTicketModelList) {
    //   totalEstimateTime += element.serviceModel.estimatedTime;
    // }
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
