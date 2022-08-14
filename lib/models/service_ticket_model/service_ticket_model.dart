import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';
part 'service_ticket_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceTicketModel {
  final int? id;
  final int serviceId;
  final int? ticketId;
  final int petId;
  @JsonKey(name: 'service')
  final CenterServiceModel? centerServiceModel;

  ServiceTicketModel({
    this.id,
    required this.serviceId,
    this.ticketId,
    this.centerServiceModel,
    required this.petId,
  });

  factory ServiceTicketModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceTicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceTicketModelToJson(this);
}
