import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/configs/path.dart';

part 'species_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SpeciesModel {
  final int id;
  final String name;
  String? imageUrl;
  final String? description;
  final bool isBreeding;

  SpeciesModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.isBreeding,
  }) {
    switch (name) {
      case 'Dog':
      case 'Chó':
        imageUrl = IMAGE_PATH + DOG_PNG;
        break;
      case 'Cat':
      case 'Mèo':
        imageUrl = IMAGE_PATH + CAT_PNG;
        break;
      case 'Fish':
      case 'Cá':
        imageUrl = IMAGE_PATH + FISH_PNG;
        break;
      case 'Bird':
      case 'Chim':
        imageUrl = IMAGE_PATH + BIRD_PNG;
        break;
      case 'Iguana':
      case 'Thằn lằn':
        imageUrl = IMAGE_PATH + IGUANA_PNG;
        break;
      default:
        imageUrl = null;
    }
  }

  factory SpeciesModel.fromJson(Map<String, dynamic> json) =>
      _$SpeciesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpeciesModelToJson(this);
}
