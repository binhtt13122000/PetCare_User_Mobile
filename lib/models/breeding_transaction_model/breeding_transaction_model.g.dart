// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeding_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedingTransactionModel _$BreedingTransactionModelFromJson(
        Map<String, dynamic> json) =>
    BreedingTransactionModel(
      id: json['id'] as int,
      petMaleId: json['petMaleId'] as int,
      petFemaleId: json['petFemaleId'] as int,
      reasonCancel: json['reasonCancel'] as String?,
      status: json['status'] as String,
      postId: json['postId'] as int?,
      createdTime: DateTime.parse(json['createdTime'] as String),
      meetingTime: DateTime.parse(json['meetingTime'] as String),
      serviceFee: json['serviceFee'] as int?,
      pickupMalePetTime: json['pickupMalePetTime'] == null
          ? null
          : DateTime.parse(json['pickupMalePetTime'] as String),
      evidence: json['evidence'] as String?,
      description: json['description'] as String?,
      star: json['star'] as int?,
      review: json['review'] as String?,
      ownerPetMaleId: json['ownerPetMaleId'] as int,
      ownerPetFemaleId: json['ownerPetFemaleId'] as int,
      branchId: json['branchId'] as int?,
      dateOfBreeding: json['dateOfBreeding'] == null
          ? null
          : DateTime.parse(json['dateOfBreeding'] as String),
      point: json['point'] as int?,
      cancelTime: json['cancelTime'] == null
          ? null
          : DateTime.parse(json['cancelTime'] as String),
      placeMeeting: json['placeMeeting'] as String,
      paymentTime: json['paymentTime'] == null
          ? null
          : DateTime.parse(json['paymentTime'] as String),
      timeToCheckBreeding: json['timeToCheckBreeding'] == null
          ? null
          : DateTime.parse(json['timeToCheckBreeding'] as String),
      isSuccess: json['isSuccess'] as bool?,
      postModel: json['post'] == null
          ? null
          : PostModel.fromJson(json['post'] as Map<String, dynamic>),
      malePetModel: PetModel.fromJson(json['petMale'] as Map<String, dynamic>),
      femalePetModel:
          PetModel.fromJson(json['petFemale'] as Map<String, dynamic>),
      ownerPetMaleCustomerModel:
          CustomerModel.fromJson(json['ownerPetMale'] as Map<String, dynamic>),
      ownerPetFemaleCustomerModel: CustomerModel.fromJson(
          json['ownerPetFemale'] as Map<String, dynamic>),
      petComboModelList: (json['petCombos'] as List<dynamic>?)
          ?.map((e) => PetComboModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      branchModel: json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      breedingBranchModel: json['breedingBranch'] == null
          ? null
          : BranchModel.fromJson(
              json['breedingBranch'] as Map<String, dynamic>),
      dateOfFinish: json['dateOfFinish'] == null
          ? null
          : DateTime.parse(json['dateOfFinish'] as String),
    );

Map<String, dynamic> _$BreedingTransactionModelToJson(
        BreedingTransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petMaleId': instance.petMaleId,
      'petFemaleId': instance.petFemaleId,
      'reasonCancel': instance.reasonCancel,
      'status': instance.status,
      'postId': instance.postId,
      'createdTime': instance.createdTime.toIso8601String(),
      'meetingTime': instance.meetingTime.toIso8601String(),
      'serviceFee': instance.serviceFee,
      'pickupMalePetTime': instance.pickupMalePetTime?.toIso8601String(),
      'evidence': instance.evidence,
      'description': instance.description,
      'star': instance.star,
      'review': instance.review,
      'ownerPetMaleId': instance.ownerPetMaleId,
      'ownerPetFemaleId': instance.ownerPetFemaleId,
      'branchId': instance.branchId,
      'dateOfBreeding': instance.dateOfBreeding?.toIso8601String(),
      'point': instance.point,
      'cancelTime': instance.cancelTime?.toIso8601String(),
      'placeMeeting': instance.placeMeeting,
      'paymentTime': instance.paymentTime?.toIso8601String(),
      'timeToCheckBreeding': instance.timeToCheckBreeding?.toIso8601String(),
      'isSuccess': instance.isSuccess,
      'dateOfFinish': instance.dateOfFinish?.toIso8601String(),
      'petCombos': instance.petComboModelList?.map((e) => e.toJson()).toList(),
      'breedingBranch': instance.breedingBranchModel?.toJson(),
      'branch': instance.branchModel?.toJson(),
      'post': instance.postModel?.toJson(),
      'petMale': instance.malePetModel.toJson(),
      'petFemale': instance.femalePetModel.toJson(),
      'ownerPetMale': instance.ownerPetMaleCustomerModel.toJson(),
      'ownerPetFemale': instance.ownerPetFemaleCustomerModel.toJson(),
    };
