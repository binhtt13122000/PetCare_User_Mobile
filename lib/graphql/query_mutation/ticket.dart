// ignore_for_file: constant_identifier_names

const String FETCH_TICKET_LIST_BY_PHONE_NUMBER = r'''
query MyQuery($phoneNumber: String) {
  ticket(where: {phoneNumber: {_eq: $phoneNumber}}, order_by: {id: desc}) {
    cancelReason
    date
    description
    email
    id
    meetingTime
    name
    phoneNumber
    status
    title
    type
    media {
      id
      url
    }
  }
}
''';
