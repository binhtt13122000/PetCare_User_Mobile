// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_combo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetComboModel _$PetComboModelFromJson(Map<String, dynamic> json) =>
    PetComboModel(
      id: json['id'] as int,
      registerTime: DateTime.parse(json['registerTime'] as String),
      isCompleted: json['isCompleted'] as bool,
      isDraft: json['isDraft'] as bool,
      paymentMethod: json['paymentMethod'] as String,
      orderTotal: json['orderTotal'] as int,
      point: json['point'] as int,
      petId: json['petId'] as int,
      branchId: json['branchId'] as int,
      comboId: json['comboId'] as int,
      breedingTransactionId: json['breedingTransactionId'] as int?,
      petModel: PetModel.fromJson(json['pet'] as Map<String, dynamic>),
      branchModel: BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      servicesComboModel:
          ServicesComboModel.fromJson(json['combo'] as Map<String, dynamic>),
      petComboDetailModelList: (json['petComboServices'] as List<dynamic>?)
          ?.map((e) => PetComboDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PetComboModelToJson(PetComboModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registerTime': instance.registerTime.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'isDraft': instance.isDraft,
      'paymentMethod': instance.paymentMethod,
      'orderTotal': instance.orderTotal,
      'point': instance.point,
      'petId': instance.petId,
      'branchId': instance.branchId,
      'comboId': instance.comboId,
      'breedingTransactionId': instance.breedingTransactionId,
      'pet': instance.petModel.toJson(),
      'branch': instance.branchModel.toJson(),
      'combo': instance.servicesComboModel.toJson(),
      'petComboServices':
          instance.petComboDetailModelList?.map((e) => e.toJson()).toList(),
    };
