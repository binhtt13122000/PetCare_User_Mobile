import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';

import 'package:petapp_mobile/models/media_model/media_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PostModel {
  final DateTime? approveTime;
  final int branchId;
  final DateTime? cancelTime;
  final DateTime createTime;
  final int customerId;
  final String? description;
  final int id;
  final bool isVaccineInject;
  final DateTime? meetingTime;
  final int petId;
  final int provisionalTotal;
  final String? reasonCancel;
  final String? reasonReject;
  final DateTime? rejectTime;
  final int sellerReceive;
  final int shopFee;
  final String status;
  final String title;
  final String type;
  @JsonKey(name: 'pet')
  final PetModel? petModel;
  @JsonKey(name: 'customer')
  final CustomerModel? customerModel;
  @JsonKey(name: 'media')
  final List<MediaModel>? mediaModels;

  PostModel(
      {this.approveTime,
      required this.branchId,
      this.cancelTime,
      required this.createTime,
      required this.customerId,
      this.description,
      required this.id,
      required this.isVaccineInject,
      this.meetingTime,
      required this.petId,
      required this.provisionalTotal,
      this.reasonCancel,
      this.reasonReject,
      this.rejectTime,
      required this.sellerReceive,
      required this.shopFee,
      required this.status,
      required this.title,
      required this.type,
      this.petModel,
      this.mediaModels,
      this.customerModel});

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
