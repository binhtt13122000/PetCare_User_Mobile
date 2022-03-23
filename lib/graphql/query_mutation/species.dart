// ignore_for_file: constant_identifier_names

const String FETCH_ALL_SPECIES = r'''
query MyQuery {
  species(where: {isActive: {_eq: true}}) {
    id
    isBreeding
    name
  }
}
''';
