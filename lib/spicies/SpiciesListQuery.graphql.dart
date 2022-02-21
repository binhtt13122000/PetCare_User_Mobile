import 'package:gql/ast.dart';
import 'package:json_annotation/json_annotation.dart';
part 'SpiciesListQuery.graphql.g.dart';

@JsonSerializable()
class VariablesQuerySpiciesListQuery extends JsonSerializable {
  VariablesQuerySpiciesListQuery({this.limit, this.offset});

  @override
  factory VariablesQuerySpiciesListQuery.fromJson(Map<String, dynamic> json) =>
      _$VariablesQuerySpiciesListQueryFromJson(json);

  final int? limit;

  final int? offset;

  @override
  Map<String, dynamic> toJson() => _$VariablesQuerySpiciesListQueryToJson(this);
}

@JsonSerializable()
class QuerySpiciesListQuery extends JsonSerializable {
  QuerySpiciesListQuery({required this.spicies});

  @override
  factory QuerySpiciesListQuery.fromJson(Map<String, dynamic> json) =>
      _$QuerySpiciesListQueryFromJson(json);

  final List<QuerySpiciesListQuery$spicies> spicies;

  @override
  Map<String, dynamic> toJson() => _$QuerySpiciesListQueryToJson(this);
}

const QUERY_SPICIES_LIST_QUERY = const DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SpiciesListQuery'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '10')),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'offset')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '0')),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'spicies'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'offset'),
                  value: VariableNode(name: NameNode(value: 'offset')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'description'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'isActive'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ])),
]);

@JsonSerializable()
class QuerySpiciesListQuery$spicies extends JsonSerializable {
  QuerySpiciesListQuery$spicies(
      {this.description, required this.isActive, required this.name});

  @override
  factory QuerySpiciesListQuery$spicies.fromJson(Map<String, dynamic> json) =>
      _$QuerySpiciesListQuery$spiciesFromJson(json);

  final String? description;

  final bool isActive;

  final String name;

  @override
  Map<String, dynamic> toJson() => _$QuerySpiciesListQuery$spiciesToJson(this);
}
