// ignore_for_file: constant_identifier_names

const FETCH_BREED_BY_SPECIES_ID = r'''
query MyQuery($species_id: Int) {
  breed(where: {species: {id: {_eq: $species_id}}}) {
    id
    name
    description
  }
}
''';
