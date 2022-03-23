import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/media_model/media_model.dart';

part 'ticket_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TicketModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String? email;
  final String type;
  final String title;
  final DateTime date;
  final String description;
  //DateTime? meetingTime;
  String? cancelReason;
  String status;
  @JsonKey(name: 'media')
  final List<MediaModel> evidence;

  TicketModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.type,
    required this.title,
    required this.date,
    required this.description,
    //this.meetingTime,
    this.cancelReason,
    required this.status,
    required this.evidence,
    this.email,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
