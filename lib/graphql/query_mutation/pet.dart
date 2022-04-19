// ignore_for_file: constant_identifier_names

const FETCH_PET_LIST_BY_ACCOUNT_ID = r'''
query MyQuery($accountId: Int, $_neq: pet_status_enum = "DELETED") {
  pet(where: {pet_owners: {accountId: {_eq: $accountId}}, status: {_neq: $_neq}}, order_by: {id: desc}) {
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

const FETCH_PET_LIST_WITHOUT_BREED_FOR_CREATE_POST = r'''
query MyQuery($accountId: Int, $speciesId: Int) {
  pet(where: {pet_owners: {accountId: {_eq: $accountId}}, status: {_in: ["NOT_VERIFIED", "VERIFIED"]}, category: {speciesId: {_eq: $speciesId}}}, order_by: {id: desc}) {
    ageRange
    avatar
    gender
    id
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

const FETCH_PET_LIST_WITH_BREED_FOR_CREATE_POST = r'''
query MyQuery($accountId: Int, $speciesId: Int, $breedId: Int) {
  pet(where: {pet_owners: {accountId: {_eq: $accountId}}, status: {_in: ["NOT_VERIFIED", "VERIFIED"]}, category: {speciesId: {_eq: $speciesId}}, categoryId: {_eq: $breedId}}, order_by: {id: desc}) {
    ageRange
    avatar
    gender
    id
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

const FETCH_PET_LIST_FOR_CREATE_POST = r'''
query MyQuery($accountId: Int) {
  pet(where: {pet_owners: {accountId: {_eq: $accountId}}, status: {_in: ["NOT_VERIFIED", "VERIFIED"]}}, order_by: {id: desc}) {
    ageRange
    avatar
    gender
    id
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
