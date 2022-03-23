// ignore_for_file: constant_identifier_names

const FETCH_PET_LIST_BY_ACCOUNT_ID = r'''
query MyQuery($_eq: Int, $_neq: pet_status_enum = "DELETED") {
  pet(where: {pet_owners: {accountId: {_eq: $_eq}}, status: {_neq: $_neq}}, order_by: {id: desc}) {
    ageRange
    avatar
    bloodGroup
    color
    description
    dob
    id
    gender
    isSeed
    name
    status
    category {
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
  }
}
''';
