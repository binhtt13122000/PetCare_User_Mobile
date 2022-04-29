import 'package:json_annotation/json_annotation.dart';
part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel {
  final int id;
  final String firstName;
  final String lastName;
  final String? address;
  final String gender;
  final String avatar;
  final double star;
  final int point;
  final int numberFollowers;
  final int numberReviewers;
  final String? bankName;
  final String? bankCode;
  final String? bankBranch;

  CustomerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.address,
    required this.gender,
    required this.avatar,
    required this.star,
    required this.point,
    required this.numberFollowers,
    required this.numberReviewers,
    this.bankName,
    this.bankCode,
    this.bankBranch,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}