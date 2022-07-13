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
  final int? lat;
  final int? lng;
  final String phoneNumber;
  final String representativeName;
  final String name;

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
    required this.representativeName,
    required this.name,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}
