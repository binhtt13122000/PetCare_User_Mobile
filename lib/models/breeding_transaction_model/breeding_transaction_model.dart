import 'package:json_annotation/json_annotation.dart';

import 'package:petapp_mobile/models/customer_model/customer_model.dart';
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
  final int postId;
  final DateTime createdTime;
  final DateTime meetingTime;
  final int sellerReceive;
  final int serviceFee;
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
  final DateTime? transactionTime;
  final String placeMeeting;

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
    required this.postId,
    required this.createdTime,
    required this.meetingTime,
    required this.sellerReceive,
    required this.serviceFee,
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
    this.postModel,
    required this.malePetModel,
    required this.femalePetModel,
    required this.ownerPetMaleCustomerModel,
    required this.ownerPetFemaleCustomerModel,
    required this.transactionFee,
    this.transactionTime,
    required this.placeMeeting,
  });

  factory BreedingTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$BreedingTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreedingTransactionModelToJson(this);
}
