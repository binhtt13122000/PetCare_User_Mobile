// ignore_for_file: constant_identifier_names

const FETCH_SALE_TRANSACTION_LIST_BY_BUYER_ID = r'''
query MyQuery($_eq1: Int, $_eq2: Int) {
  sale_transaction(where: {_or: [{sellerId: {_eq: $_eq1}}, {buyerId: {_eq: $_eq2}}]}) {
    createTime
    buyerId
    deposit
    description
    id
    payForSeller
    payForSellerTime
    payFromBuyerTime
    totalPrice
    status
    sellerId
    reasonCancel
    petId
    media {
      id
      url
    }
    mediaBySaletransactionsellercontractid {
      id
      url
    }
    post {
      id
      media {
        id
        url
      }
      pet {
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
            id
            description
            isBreeding
            name
          }
        }
      }
    }
  }
}
''';
