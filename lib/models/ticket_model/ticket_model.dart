import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/service_ticket_model/service_ticket_model.dart';

part 'ticket_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TicketModel {
  final int id;
  final DateTime createdTime;
  final DateTime meetingDate;
  final int startTime;
  final int endTime;
  final int branchId;
  final int customerId;
  final String status;
  final String type;
  @JsonKey(ignore: true)
  late int totalEstimateTime;
  @JsonKey(name: 'serviceTickets')
  final List<ServiceTicketModel>? serviceTicketModelList;
  @JsonKey(name: 'branch')
  final BranchModel? branchModel;
  @JsonKey(ignore: true)
  late Map<int, List<ServiceTicketModel>> serviceTicketMap;
  @JsonKey(ignore: true)
  late Map<PetModel, List<ServiceTicketModel>> serviceTicketWithPetModelMap;

  TicketModel(
      {required this.id,
      required this.createdTime,
      required this.meetingDate,
      required this.startTime,
      required this.endTime,
      required this.branchId,
      required this.customerId,
      required this.status,
      required this.serviceTicketModelList,
      this.branchModel,
      required this.type}) {
    totalEstimateTime = endTime - startTime;
    serviceTicketMap = {};
    if (serviceTicketModelList != null) {
      for (var element in serviceTicketModelList!) {
        if (serviceTicketMap.containsKey(element.petId)) {
          serviceTicketMap[element.petId]!.add(element);
        } else {
          serviceTicketMap.addAll({
            element.petId: [element]
          });
        }
      }
    }
    serviceTicketWithPetModelMap = {};
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
