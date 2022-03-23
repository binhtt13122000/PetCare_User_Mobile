// ignore_for_file: constant_identifier_names

const FETCH_PURCHASE_POST_LIST = r'''
query MyQuery($ltPrice: Int, $gtePrice: Int, $gender: [pet_gender_enum!], $isSeed: [Boolean!], $ltAgeRange: Int, $gteAgeRange: Int, $breedName: order_by, $price: order_by, $speciesId: Int, $status: post_status_enum, $breeds: [Int!]) {
  post(where: {pet: {category: {species: {id: {_eq: $speciesId}}, id: {_in: $breeds}}, gender: {_in: $gender}, isSeed: {_in: $isSeed}, ageRange: {_lt: $ltAgeRange}, _and: {ageRange: {_gte: $gteAgeRange}}}, price: {_lt: $ltPrice}, _and: {price: {_gte: $gtePrice}, status: {_eq: $status}}}, order_by: {pet: {category: {name: $breedName}}, price: $price}) {
    createTime
    deposit
    description
    effectiveTime
    id
    price
    status
    title
    type
    pet {
      ageRange
      avatar
      bloodGroup
      description
      color
      dob
      id
      gender
      isSeed
      name
      status
      category {
        id
        name
        description
        species {
          id
          name
          isBreeding
          description
        }
      }
    }
  }
}
''';

const FETCH_PURCHASE_POST_LIST_WITHOUT_BREED = r'''
query MyQuery($ltPrice: Int, $gtePrice: Int, $gender: [pet_gender_enum!], $isSeed: [Boolean!], $ltAgeRange: Int, $gteAgeRange: Int, $breedName: order_by, $price: order_by, $speciesId: Int, $status: post_status_enum) {
  post(where: {pet: {category: {species: {id: {_eq: $speciesId}}}, gender: {_in: $gender}, isSeed: {_in: $isSeed}, ageRange: {_lt: $ltAgeRange}, _and: {ageRange: {_gte: $gteAgeRange}}}, price: {_lt: $ltPrice}, _and: {price: {_gte: $gtePrice}, status: {_eq: $status}}}, order_by: {pet: {category: {name: $breedName}}, price: $price}) {
    createTime
    deposit
    description
    effectiveTime
    id
    price
    status
    title
    type
    pet {
      ageRange
      avatar
      bloodGroup
      description
      color
      dob
      id
      gender
      isSeed
      name
      status
      category {
        id
        name
        description
        species {
          id
          name
          isBreeding
          description
        }
      }
    }
  }
}
''';

const FETCH_ALL_PURCHASE_POST_LIST = r'''
query MyQuery {
  post(where: {status: {_eq: "PUBLISHED"}}) {
    createTime
    deposit
    description
    effectiveTime
    id
    price
    status
    title
    type
    pet {
      ageRange
      avatar
      bloodGroup
      description
      color
      dob
      id
      gender
      isSeed
      name
      status
      category {
        id
        name
        description
        species {
          id
          name
          isBreeding
          description
        }
      }
    }
  }
}
''';
