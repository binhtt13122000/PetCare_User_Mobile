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
  final int point;
  final String email;
  final String? phoneNumber;
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
    required this.email,
    this.bankName,
    this.bankCode,
    this.bankBranch,
    this.phoneNumber,
    required this.point,
  }) {
    List<String> words = lastName.split(' ');
    avatarCharacter = words[words.length - 1][0].toUpperCase();
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
