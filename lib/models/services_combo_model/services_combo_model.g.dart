// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_combo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesComboModel _$ServicesComboModelFromJson(Map<String, dynamic> json) =>
    ServicesComboModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      isActive: json['isActive'] as bool,
      price: json['price'] as int,
      petServicesComboDetailModelList: (json['comboServices'] as List<dynamic>?)
          ?.map((e) =>
              ServicesComboDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesComboModelToJson(ServicesComboModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'isActive': instance.isActive,
      'price': instance.price,
      'comboServices': instance.petServicesComboDetailModelList
          ?.map((e) => e.toJson())
          .toList(),
    };
