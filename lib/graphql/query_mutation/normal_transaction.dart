// ignore_for_file: constant_identifier_names

const FETCH_NORMAL_TRANSACTION_LIST_BY_CUSTOMER_ID = r'''
query MyQuery($_customerId: Int) {
  order(where: {customerId: {_eq: $_customerId}}, order_by: {id: desc}) {
    description
    id
    orderTotal
    payment
    paymentMethod
    paymentTime
    point
    status
    promotionId
    provisionalTotal
    branch {
      address
      description
      email
      id
      image
      isActive
      lat
      lng
      numberReviewers
      phoneNumber
      representativeName
      star
    }
  }
}
''';

const FETCH_NORMAL_TRANSACTION_BY_TRANSACTION_ID = r'''
query MyQuery($_orderId: Int) {
  order(where: {id: {_eq: $_orderId}}) {
    branch {
      address
      description
      email
      id
      image
      isActive
      lat
      lng
      numberReviewers
      phoneNumber
      representativeName
      star
    }
    description
    id
    orderTotal
    payment
    paymentMethod
    paymentTime
    point
    status
    promotionId
    provisionalTotal
    order_details {
      service {
        name
        price
        id
        description
        healthCheckTemplate
        isHealthCheck
        status
        unit
      }
      description
      id
      price
    }
    promotion {
      description
      promo
      name
      maxMoneyPromo
      id
      applyMoney
      expireTime
      startTime
      status
    }
  }
}
''';
