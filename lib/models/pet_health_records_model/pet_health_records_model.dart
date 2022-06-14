import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/vaccine_model/vaccine_model.dart';

part 'pet_health_records_model.g.dart';

@JsonSerializable()
class PetHealthRecordModel {
  final int id;
  final DateTime dateOfInjection;
  final String? description;
  final String vaccineType;
  final String type;
  final int? vaccineId;
  final int petId;
  @JsonKey(name: 'vaccine')
  VaccineModel? vaccineModel;

  final int branchId;
  PetHealthRecordModel({
    required this.id,
    required this.dateOfInjection,
    this.description,
    required this.vaccineType,
    required this.type,
    this.vaccineId,
    required this.petId,
    required this.branchId,
    this.vaccineModel,
  });

  factory PetHealthRecordModel.fromJson(Map<String, dynamic> json) =>
      _$PetHealthRecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetHealthRecordModelToJson(this);
}
