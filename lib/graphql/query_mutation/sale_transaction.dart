// ignore_for_file: constant_identifier_names

const FETCH_SALE_TRANSACTION_LIST_BY_BUYER_ID = r'''
query MyQuery($customerId: Int = 1) {
  sale_transaction(where: {_or: [{sellerId: {_eq: $customerId}}, {buyerId: {_eq: $customerId}}]}) {
 createdTime
    description
    id
    meetingTime
    paymentMethod
    petId
    placeMeeting
    postId
    review
    reasonCancel
    sellerId
    sellerReceive
    star
    status
    transactionFee
    transactionTime
    transactionTotal
    point
    post {
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
      status
      shopFee
      sellerReceive
      title
      type
      media {
        id
        type
        url
      }
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
    buyerId
    pet {
      avatar
      breedId
      breed {
        id
        name
        isActive
        speciesId
        species {
          description
          id
          isBreeding
          isActive
          isInject
          name
        }
        description
      }
      color
      description
      dob
      gender
      id
      isSeed
      name
      specialMarkings
      status
      vaccineDescription
    }
    customerByBuyerid {
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

const FETCH_SALE_TRANSACTION_BY_ID = r'''
query MyQuery($id: Int) {
  sale_transaction(where: {id: {_eq: $id}}) {
    createdTime
    description
    id
    meetingTime
    paymentMethod
    petId
    placeMeeting
    postId
    review
    reasonCancel
    sellerId
    sellerReceive
    star
    status
    transactionFee
    transactionTime
    transactionTotal
    point
    post {
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
      status
      shopFee
      sellerReceive
      title
      type
      media {
        id
        type
        url
      }
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
    buyerId
    pet {
      avatar
      breedId
      breed {
        id
        name
        isActive
        speciesId
        species {
          description
          id
          isBreeding
          isActive
          isInject
          name
        }
        description
      }
      color
      description
      dob
      gender
      id
      isSeed
      name
      specialMarkings
      status
      vaccineDescription
    }
    customerByBuyerid {
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

const UPDATE_SALE_TRANSACTION_REVIEW_BUY_ID = r'''
mutation MyMutation($id: Int, $star: Int, $review: String) {
  update_sale_transaction(where: {id: {_eq: $id}}, _set: {star: $star, review: $review}) {
    returning {
      id
    }
  }
}
''';
