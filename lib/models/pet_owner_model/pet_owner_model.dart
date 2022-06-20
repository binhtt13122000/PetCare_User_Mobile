import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';

part 'pet_owner_model.g.dart';

@JsonSerializable()
class PetOwnerModel {
  final int id;
  final bool isCurrentOwner;
  final DateTime date;
  final int petId;
  final int customerId;
  @JsonKey(name: 'customer')
  final CustomerModel customerModel;

  PetOwnerModel({
    required this.id,
    required this.isCurrentOwner,
    required this.date,
    required this.petId,
    required this.customerId,
    required this.customerModel,
  });

  factory PetOwnerModel.fromJson(Map<String, dynamic> json) =>
      _$PetOwnerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetOwnerModelToJson(this);
}
