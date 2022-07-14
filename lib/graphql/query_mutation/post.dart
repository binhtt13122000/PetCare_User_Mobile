// ignore_for_file: constant_identifier_names

const FETCH_PURCHASE_POST_LIST = r'''
query MyQuery($ltPrice: Int, $gtePrice: Int, $gender: [pet_gender_enum!], $isSeed: [Boolean!], $breedName: order_by, $price: order_by, $speciesId: Int, $status: post_status_enum, $breeds: [Int!], $customerId: Int = 0, $lteDob: timestamp = "", $gteDob: timestamp = "", $limit: Int = 8, $offset: Int = 0) {
  post(where: {pet: {breed: {species: {id: {_eq: $speciesId}}, id: {_in: $breeds}}, gender: {_in: $gender}, isSeed: {_in: $isSeed}, dob: {_lte: $lteDob, _gte: $gteDob}}, transactionTotal: {_lt: $ltPrice}, _and: {transactionTotal: {_gte: $gtePrice}, status: {_eq: $status}, customerId: {_neq: $customerId}}}, order_by: {pet: {breed: {name: $breedName}}, transactionTotal: $price}, limit: $limit, offset: $offset) {
    description
    createTime
    petId
    id
    transactionTotal
    status
    sellerReceive
    
    type
    shopFee
    title
    branchId
    branch {
      id
      name
      representativeName
      lat
      lng
      email
      phoneNumber
      
      
      address
      isActive
    }
    customerId
    customer {
      id
      firstName
      lastName
      address
      gender
      
      point
      email
      
    }
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
  post_aggregate(where: {pet: {breed: {species: {id: {_eq: $speciesId}}, id: {_in: $breeds}}, gender: {_in: $gender}, isSeed: {_in: $isSeed}, dob: {_lte: $lteDob, _gte: $gteDob}}, transactionTotal: {_lt: $ltPrice}, _and: {transactionTotal: {_gte: $gtePrice}, status: {_eq: $status}, customerId: {_neq: $customerId}}}, order_by: {pet: {breed: {name: $breedName}}, transactionTotal: $price}) {
    aggregate {
      count
    }
  }
}
''';

const FETCH_ALL_PURCHASE_POST_LIST_WITHOUT_SPECIES = r'''
query MyQuery($ltPrice: Int, $gtePrice: Int, $gender: [pet_gender_enum!], $isSeed: [Boolean!], $breedName: order_by, $price: order_by, $status: post_status_enum, $customerId: Int, $lteDob: timestamp = "", $gteDob: timestamp = "", $limit: Int = 8, $offset: Int = 0, $title: String) {
  post(where: {pet: {gender: {_in: $gender}, isSeed: {_in: $isSeed}, dob: {_lte: $lteDob, _gte: $gteDob}}, transactionTotal: {_lt: $ltPrice}, _and: {transactionTotal: {_gte: $gtePrice}, status: {_eq: $status}, customerId: {_neq: $customerId}}, title: {_ilike: $title}}, order_by: {pet: {breed: {name: $breedName}}, transactionTotal: $price}, limit: $limit, offset: $offset) {
    
    id
    petId
    createTime
    description
    transactionTotal
    status
    sellerReceive
    type
    shopFee
    title
    branchId
    branch {
      id
      name
      representativeName
      lat
      lng
      email
      phoneNumber
      
      
      address
      isActive
    }
    customerId
    customer {
      id
      firstName
      lastName
      address
      gender
      
      point
      email
      
    }
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
  post_aggregate(where: {pet: {gender: {_in: $gender}, isSeed: {_in: $isSeed}, dob: {_lte: $lteDob, _gte: $gteDob}}, transactionTotal: {_lt: $ltPrice}, _and: {transactionTotal: {_gte: $gtePrice}, status: {_eq: $status}, customerId: {_neq: $customerId}}}, order_by: {pet: {breed: {name: $breedName}}, transactionTotal: $price}) {
    aggregate {
      count
    }
  }
}
''';

const FETCH_PURCHASE_POST_LIST_WITHOUT_BREED = r'''
query MyQuery($ltPrice: Int, $gtePrice: Int, $gender: [pet_gender_enum!], $isSeed: [Boolean!], $breedName: order_by, $price: order_by, $speciesId: Int, $status: post_status_enum, $customerId: Int, $gteDob: timestamp = "", $lteDob: timestamp = "", $limit: Int = 8, $offset: Int = 0, $title: String) {
  post(where: {pet: {breed: {species: {id: {_eq: $speciesId}}}, gender: {_in: $gender}, isSeed: {_in: $isSeed}, dob: {_gte: $gteDob, _lte: $lteDob}}, transactionTotal: {_lt: $ltPrice}, _and: {transactionTotal: {_gte: $gtePrice}, status: {_eq: $status}, customerId: {_neq: $customerId}}, title: {_ilike: $title}}, order_by: {pet: {breed: {name: $breedName}}, transactionTotal: $price}, limit: $limit, offset: $offset) {
    createTime
    description
    petId
    
    id
    transactionTotal
    status
    sellerReceive
    type
    shopFee
    title
    branchId
    branch {
      id
      name
      representativeName
      lat
      lng
      email
      phoneNumber
      
      
      address
      isActive
    }
    customerId
    customer {
      id
      firstName
      lastName
      address
      gender
      
      point
      email
      
    }
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
  post_aggregate(where: {pet: {breed: {species: {id: {_eq: $speciesId}}}, gender: {_in: $gender}, isSeed: {_in: $isSeed}, dob: {_gte: $gteDob, _lte: $lteDob}}, transactionTotal: {_lt: $ltPrice}, _and: {transactionTotal: {_gte: $gtePrice}, status: {_eq: $status}, customerId: {_neq: $customerId}}}, order_by: {pet: {breed: {name: $breedName}}, transactionTotal: $price}) {
    aggregate {
      count
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
    
    meetingTime
    petId
    transactionTotal
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
    
    meetingTime
    petId
    transactionTotal
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
      
      phoneNumber
      point
      
    }
  }
}
''';
