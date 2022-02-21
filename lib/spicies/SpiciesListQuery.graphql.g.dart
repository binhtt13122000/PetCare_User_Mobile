// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SpiciesListQuery.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariablesQuerySpiciesListQuery _$VariablesQuerySpiciesListQueryFromJson(
    Map<String, dynamic> json) {
  return VariablesQuerySpiciesListQuery(
    limit: json['limit'] as int?,
    offset: json['offset'] as int?,
  );
}

Map<String, dynamic> _$VariablesQuerySpiciesListQueryToJson(
        VariablesQuerySpiciesListQuery instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
    };

QuerySpiciesListQuery _$QuerySpiciesListQueryFromJson(
    Map<String, dynamic> json) {
  return QuerySpiciesListQuery(
    spicies: (json['spicies'] as List<dynamic>)
        .map((e) =>
            QuerySpiciesListQuery$spicies.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QuerySpiciesListQueryToJson(
        QuerySpiciesListQuery instance) =>
    <String, dynamic>{
      'spicies': instance.spicies,
    };

QuerySpiciesListQuery$spicies _$QuerySpiciesListQuery$spiciesFromJson(
    Map<String, dynamic> json) {
  return QuerySpiciesListQuery$spicies(
    description: json['description'] as String?,
    isActive: json['isActive'] as bool,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$QuerySpiciesListQuery$spiciesToJson(
        QuerySpiciesListQuery$spicies instance) =>
    <String, dynamic>{
      'description': instance.description,
      'isActive': instance.isActive,
      'name': instance.name,
    };
