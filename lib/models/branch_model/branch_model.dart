import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BranchModel {
  final String? address;
  final String? description;
  final String? email;
  final int id;
  final String? image;
  final bool isActive;
  final String? lat;
  final String? lng;
  final String phoneNumber;
  final int star;
  final String representativeName;
  final int numberReviewers;

  BranchModel({
    this.address,
    this.description,
    this.email,
    required this.id,
    this.image,
    required this.isActive,
    this.lat,
    this.lng,
    required this.phoneNumber,
    required this.star,
    required this.representativeName,
    required this.numberReviewers,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}