// ignore_for_file: constant_identifier_names

const FETCH_PET_LIST_TO_CREATE_POST = r'''
query MyQuery($customerId: Int) {
  pet(where: {pet_owners: {customerId: {_eq: $customerId}}, status: {_eq: "NORMAL"}}, order_by: {id: desc}) {
    avatar
    color
    description
    dob
    id
    gender
    isSeed
    name
    status
    breed {
      description
      id
      name
      species {
        name
        isBreeding
        id
        description
      }
    }
    specialMarkings
    vaccineDescription
  }
}
''';
