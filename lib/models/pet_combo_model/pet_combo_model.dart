import 'package:json_annotation/json_annotation.dart';

import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/pet_combo_detail_model/pet_combo_detail_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/services_combo_model/services_combo_model.dart';

part 'pet_combo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PetComboModel {
  final int id;
  final DateTime registerTime;
  final bool isCompleted;
  final bool isDraft;
  final String paymentMethod;
  final int orderTotal;
  final int point;
  final int petId;
  final int branchId;
  final int comboId;
  final int? breedingTransactionId;
  @JsonKey(name: 'pet')
  final PetModel petModel;
  @JsonKey(name: 'branch')
  final BranchModel branchModel;
  @JsonKey(name: 'combo')
  final ServicesComboModel servicesComboModel;
  @JsonKey(name: 'petComboServices')
  final List<PetComboDetailModel>? petComboDetailModelList;

  PetComboModel({
    required this.id,
    required this.registerTime,
    required this.isCompleted,
    required this.isDraft,
    required this.paymentMethod,
    required this.orderTotal,
    required this.point,
    required this.petId,
    required this.branchId,
    required this.comboId,
    this.breedingTransactionId,
    required this.petModel,
    required this.branchModel,
    required this.servicesComboModel,
    this.petComboDetailModelList,
  });

  factory PetComboModel.fromJson(Map<String, dynamic> json) =>
      _$PetComboModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetComboModelToJson(this);
}
