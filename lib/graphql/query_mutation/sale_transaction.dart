// ignore_for_file: constant_identifier_names


const UPDATE_SALE_TRANSACTION_REVIEW_BUY_ID = r'''
mutation MyMutation($id: Int, $star: Int, $review: String) {
  update_sale_transaction(where: {id: {_eq: $id}}, _set: {star: $star, review: $review}) {
    returning {
      id
    }
  }
}
''';
