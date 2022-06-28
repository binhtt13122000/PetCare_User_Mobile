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
  final int sellerReceive;
  final int? serviceFee;
  final int transactionTotal;
  final DateTime? pickupMalePetTime;
  final DateTime? pickupFemalePetTime;
  final String? evidence;
  final String? description;
  final String? paymentMethod;
  final int? star;
  final String? review;
  final int ownerPetMaleId;
  final int ownerPetFemaleId;
  final int? branchId;
  final DateTime? dateOfBreeding;
  final int? point;
  final DateTime? cancelTime;
  final int transactionFee;
  final String placeMeeting;
  final int? breedingBranchId;
  final bool self;
  final DateTime? paymentTime;
  final int? servicePoint;
  final DateTime? timeToCheckBreeding;
  final bool? isSuccess;
  final DateTime? realDateOfBreeding;
  final DateTime? realDateOfFinish;
  final DateTime? realTimeToCheckBreeding;
  final int? starBranch;
  final String? reviewBranch;
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

  BreedingTransactionModel({
    required this.id,
    required this.petMaleId,
    required this.petFemaleId,
    this.reasonCancel,
    required this.status,
    this.postId,
    required this.createdTime,
    required this.meetingTime,
    required this.sellerReceive,
    this.serviceFee,
    required this.transactionTotal,
    this.pickupMalePetTime,
    this.pickupFemalePetTime,
    this.evidence,
    this.description,
    this.paymentMethod,
    this.star,
    this.review,
    required this.ownerPetMaleId,
    required this.ownerPetFemaleId,
    this.branchId,
    this.dateOfBreeding,
    this.point,
    this.cancelTime,
    required this.transactionFee,
    required this.placeMeeting,
    this.breedingBranchId,
    required this.self,
    this.paymentTime,
    this.servicePoint,
    this.timeToCheckBreeding,
    this.isSuccess,
    this.realDateOfBreeding,
    this.realDateOfFinish,
    this.realTimeToCheckBreeding,
    this.starBranch,
    this.reviewBranch,
    this.postModel,
    required this.malePetModel,
    required this.femalePetModel,
    required this.ownerPetMaleCustomerModel,
    required this.ownerPetFemaleCustomerModel,
    this.petComboModelList,
    this.branchModel,
    this.breedingBranchModel,
  });

  factory BreedingTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$BreedingTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreedingTransactionModelToJson(this);
}
