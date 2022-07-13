import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';

import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:petapp_mobile/models/pet_combo_model/pet_combo_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

part 'breeding_transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BreedingTransactionModel {
  final int id;
  final int petMaleId;
  final int petFemaleId;
  final String? reasonCancel;
  final String status;
  final int? postId;
  final DateTime createdTime;
  final DateTime meetingTime;
  final int? serviceFee;
  final DateTime? pickupMalePetTime;
  final String? evidence;
  final String? description;
  final int? star;
  final String? review;
  final int ownerPetMaleId;
  final int ownerPetFemaleId;
  final int? branchId;
  final DateTime? dateOfBreeding;
  final int? point;
  final DateTime? cancelTime;
  final String placeMeeting;
  final DateTime? paymentTime;
  final DateTime? timeToCheckBreeding;
  final bool? isSuccess;
  final DateTime? dateOfFinish;

  @JsonKey(name: 'petCombos')
  final List<PetComboModel>? petComboModelList;
  @JsonKey(name: 'breedingBranch')
  final BranchModel? breedingBranchModel;
  @JsonKey(name: 'branch')
  final BranchModel? branchModel;
  @JsonKey(name: 'post')
  final PostModel? postModel;
  @JsonKey(name: 'petMale')
  final PetModel malePetModel;
  @JsonKey(name: 'petFemale')
  final PetModel femalePetModel;
  @JsonKey(name: 'ownerPetMale')
  final CustomerModel ownerPetMaleCustomerModel;
  @JsonKey(name: 'ownerPetFemale')
  final CustomerModel ownerPetFemaleCustomerModel;

  BreedingTransactionModel(
      {required this.id,
      required this.petMaleId,
      required this.petFemaleId,
      this.reasonCancel,
      required this.status,
      this.postId,
      required this.createdTime,
      required this.meetingTime,
      this.serviceFee,
      this.pickupMalePetTime,
      this.evidence,
      this.description,
      this.star,
      this.review,
      required this.ownerPetMaleId,
      required this.ownerPetFemaleId,
      this.branchId,
      this.dateOfBreeding,
      this.point,
      this.cancelTime,
      required this.placeMeeting,
      this.paymentTime,
      this.timeToCheckBreeding,
      this.isSuccess,
      this.postModel,
      required this.malePetModel,
      required this.femalePetModel,
      required this.ownerPetMaleCustomerModel,
      required this.ownerPetFemaleCustomerModel,
      this.petComboModelList,
      this.branchModel,
      this.breedingBranchModel,
      this.dateOfFinish});

  factory BreedingTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$BreedingTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreedingTransactionModelToJson(this);
}
