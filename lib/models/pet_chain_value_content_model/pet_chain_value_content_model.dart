import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

part 'pet_chain_value_content_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PetChainValueContentModel {
  final String write;
  @JsonKey(name: 'current')
  final PetModel petModel;

  PetChainValueContentModel({required this.write, required this.petModel});

  factory PetChainValueContentModel.fromJson(Map<String, dynamic> json) =>
      _$PetChainValueContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetChainValueContentModelToJson(this);
}
