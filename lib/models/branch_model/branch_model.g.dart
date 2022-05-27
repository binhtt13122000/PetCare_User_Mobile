// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
      address: json['address'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      id: json['id'] as int,
      image: json['image'] as String?,
      isActive: json['isActive'] as bool,
      lat: json['lat'] as int?,
      lng: json['lng'] as int?,
      phoneNumber: json['phoneNumber'] as String,
      star: json['star'] as int,
      representativeName: json['representativeName'] as String,
      numberReviewers: json['numberReviewers'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'description': instance.description,
      'email': instance.email,
      'id': instance.id,
      'image': instance.image,
      'isActive': instance.isActive,
      'lat': instance.lat,
      'lng': instance.lng,
      'phoneNumber': instance.phoneNumber,
      'star': instance.star,
      'representativeName': instance.representativeName,
      'numberReviewers': instance.numberReviewers,
      'name': instance.name,
    };
