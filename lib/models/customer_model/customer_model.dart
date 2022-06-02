import 'package:json_annotation/json_annotation.dart';
part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel {
  final int id;
  final String firstName;
  final String lastName;
  final String? address;
  final String gender;
  final String? avatar;
  final double star;
  final int point;
  final String email;

  final int numberReviewers;
  final String? bankName;
  final String? bankCode;
  final String? bankBranch;
  @JsonKey(ignore: true)
  late String avatarCharacter;

  CustomerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.address,
    required this.gender,
    this.avatar,
    required this.star,
    required this.point,
    required this.numberReviewers,
    required this.email,
    this.bankName,
    this.bankCode,
    this.bankBranch,
  }) {
    List<String> words = lastName.split(' ');
    avatarCharacter = words[words.length - 1][0];
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
