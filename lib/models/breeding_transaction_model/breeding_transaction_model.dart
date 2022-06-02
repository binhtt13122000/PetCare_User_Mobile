// import 'package:json_annotation/json_annotation.dart';

// import 'package:petapp_mobile/models/customer_model/customer_model.dart';
// import 'package:petapp_mobile/models/pet_model/pet_model.dart';
// import 'package:petapp_mobile/models/post_model/post_model.dart';

// part 'breeding_transaction_model.g.dart';

// @JsonSerializable(explicitToJson: true)
// class BreedingTransactionModel {
//   final int id;
//   final int petMaleId;
//   final int petFemaleId;
//   final String? reasonCancel;
//   final String status;
//   final int postId;
//   final DateTime createdTime;
//   final DateTime meetingTime;
//   final int sellerReceive;
//   final int serviceFee;
//   final int transactionTotal;
//   final DateTime? pickupMalePetTime;
//   final DateTime? pickupFemalePetTime;
//   final String? evidence;
//   final String? description;
//   final String? paymentMethod;
//   final int? star;
//   final String? review;
//   final int ownerPetMaleId;
//   final int ownerPetFemaleId;
//   final int? branchId;
//   final DateTime? dateOfBreeding;
//   final int? point;
//   final DateTime? cancelTime;


//   final int transactionFee;
//   final DateTime? transactionTime;
//   final String? placeMeeting;


//   @JsonKey(name: 'post')
//   final PostModel? postModel;
//   @JsonKey(name: 'pet')
//   final PetModel? petModel;
//   @JsonKey(name: 'ownerMale')
//   final CustomerModel buyerCustomerModel;
//   @JsonKey(name: 'seller')
//   final CustomerModel sellerCustomerModel;

//   BreedingTransactionModel(
//       {required this.createdTime,
//       this.description,
//       required this.id,
//       required this.meetingTime,
//       this.paymentMethod,
//       required this.petId,
//       required this.placeMeeting,
//       required this.postId,
//       this.review,
//       this.reasonCancel,
//       required this.sellerId,
//       required this.sellerReceive,
//       this.star,
//       required this.status,
//       required this.transactionFee,
//       this.transactionTime,
//       required this.transactionTotal,
//       required this.postModel,
//       required this.petModel,
//       required this.buyerCustomerModel,
//       required this.sellerCustomerModel,
//       required this.buyerId,
//       this.point,
//       this.cancelTime});

//   factory BreedingTransactionModel.fromJson(Map<String, dynamic> json) =>
//       _$SaleTransactionModelFromJson(json);

//   Map<String, dynamic> toJson() => _$SaleTransactionModelToJson(this);
// }
