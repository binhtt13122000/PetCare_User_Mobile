// ignore_for_file: constant_identifier_names

const FETCH_CUSTOMER_BY_ID = r'''
query MyQuery($_customerId: Int) {
  customer(where: {id: {_eq: $_customerId}}) {
    address
    bankBranch
    avatar
    bankCode
    bankName
    email
    firstName
    gender
    numberReviewers
    lastName
    isActive
    id
    numberFollowers
    phoneNumber
    point
    star
  }
}
''';
