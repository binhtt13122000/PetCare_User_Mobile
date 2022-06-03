// ignore_for_file: constant_identifier_names

const FETCH_PURCHASE_POST_LIST = r'''
query MyQuery($ltPrice: Int, $gtePrice: Int, $gender: [pet_gender_enum!], $isSeed: [Boolean!], $ltAgeRange: Int, $gteAgeRange: Int, $breedName: order_by, $price: order_by, $speciesId: Int, $status: post_status_enum, $breeds: [Int!]) {
  post(where: {pet: {breed: {species: {id: {_eq: $speciesId}}, id: {_in: $breeds}}, gender: {_in: $gender}, isSeed: {_in: $isSeed}, ageRange: {_lt: $ltAgeRange}, _and: {ageRange: {_gte: $gteAgeRange}}}, price: {_lt: $ltPrice}, _and: {price: {_gte: $gtePrice}, status: {_eq: $status}}}, order_by: {pet: {breed: {name: $breedName}}, price: $price}) {
    createTime
    description
    id
    provisionalTotal
    status
    sellerReceive
    type
    shopFee
    pet {
      avatar
      description
      color
      dob
      id
      gender
      isSeed
      name
      status
      breed {
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
    media {
      id
      url
      type
    }
    
  }
}
''';

const FETCH_PURCHASE_POST_LIST_WITHOUT_BREED = r'''
query MyQuery($ltPrice: Int, $gtePrice: Int, $gender: [pet_gender_enum!], $isSeed: [Boolean!], $ltAgeRange: Int, $gteAgeRange: Int, $breedName: order_by, $price: order_by, $speciesId: Int, $status: post_status_enum) {
  post(where: {pet: {breed: {species: {id: {_eq: $speciesId}}}, gender: {_in: $gender}, isSeed: {_in: $isSeed}, ageRange: {_lt: $ltAgeRange}, _and: {ageRange: {_gte: $gteAgeRange}}}, provisionalTotal: {_lt: $ltPrice}, _and: {provisionalTotal: {_gte: $gtePrice}, status: {_eq: $status}}}, order_by: {pet: {breed: {name: $breedName}}, provisionalTotal: $price}) {
    createTime
    description
    id
    provisionalTotal
    status
    sellerReceive
    type
    shopFee
    pet {
      avatar
      description
      color
      dob
      id
      gender
      isSeed
      name
      status
      breed {
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
    media {
      id
      url
      type
    }
  }
}
''';

const FETCH_ALL_PURCHASE_POST_LIST = r'''
query MyQuery($_customerId: Int) {
  post(where: {status: {_eq: "PUBLISHED"}, customerId: {_neq: $_customerId}}) {
    approveTime
    branchId
    cancelTime
    createTime
    customerId
    description
    id
    isVaccineInject
    meetingTime
    petId
    provisionalTotal
    reasonCancel
    reasonReject
    rejectTime
    sellerReceive
    shopFee
    status
    title
    type
    pet {
      avatar
      description
      color
      dob
      id
      gender
      isSeed
      name
      status
      breed {
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
    media {
      id
      url
      type
    }
  }
}
''';

const FETCH_ALL_PURCHASE_POST_LIST_BY_CUSTOMER_ID = r'''
query MyQuery($customerId: Int = 1) {
  post(where: {customerId: {_eq: $customerId}}, order_by: {createTime: desc}) {
    approveTime
    branchId
    cancelTime
    createTime
    customerId
    description
    id
    isVaccineInject
    meetingTime
    petId
    provisionalTotal
    reasonCancel
    reasonReject
    rejectTime
    sellerReceive
    shopFee
    status
    title
    type
    pet {
      avatar
      description
      color
      dob
      id
      gender
      isSeed
      name
      status
      breed {
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
    media {
      id
      url
      type
    }
  }
}
''';

const FETCH_PURCHASE_POST_BY_ID = r'''
query MyQuery($_postId: Int) {
  post(where: {id: {_eq: $_postId}}) {
    approveTime
    branchId
    cancelTime
    createTime
    customerId
    description
    id
    isVaccineInject
    meetingTime
    petId
    provisionalTotal
    reasonCancel
    reasonReject
    rejectTime
    sellerReceive
    shopFee
    status
    title
    type
    pet {
      avatar
      description
      color
      dob
      id
      gender
      isSeed
      name
      status
      breed {
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
    media {
      id
      url
      type
    }
    customer {
      address
      avatar
      bankBranch
      bankCode
      bankName
      email
      firstName
      gender
      id
      isActive
      lastName
      numberReviewers
      phoneNumber
      point
      star
    }
  }
}
''';

const UPDATE_NORMAL_TRANSACTION_REVIEW = r'''
mutation MyMutation($_id: Int, $_review: String, $_star: Int) {
  update_order(where: {id: {_eq: $_id}}, _set: {review: $_review, star: $_star}) {
    returning {
      id
    }
  }
}
''';
