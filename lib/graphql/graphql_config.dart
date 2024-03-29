// ignore_for_file: non_constant_identifier_names

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:petapp_mobile/configs/path.dart';

final HttpLink _httpLink = HttpLink(
  '$GRAPHL_SERVER_PATH/v1/graphql',
  defaultHeaders: <String, String>{
    "type": "HS256",
    "key": "ff85bd037259c625d1188b68e0b3f7a5ba5a2f8b0a3a1125966f5cfda4a763b3",
    "audience": "petapp",
    "issuer": "petapp-be",
    "x-hasura-admin-secret":
        "1a17b69d8e567b6dca0543de4635cf102258d51e1325249f4302de2a41d77b0f",
  },
);

final ValueNotifier<GraphQLClient> GRAPHQL_CLIENT =
    ValueNotifier<GraphQLClient>(
  GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(),
  ),
);

GraphQLClient CLIENT_TO_QUERY() {
  AuthLink authLink = AuthLink(getToken: () {
    return null;
  });

  final Link link = authLink.concat(_httpLink);
  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
}
