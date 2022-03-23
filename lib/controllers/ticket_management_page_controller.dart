import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';

class TicketManagementPageController extends GetxController {
  ValueNotifier<GraphQLClient> graphqlClient = GRAPHQL_CLIENT;
  final RxMap<String, int> petManagementTableHeaders = {
    'Title': 0,
    'Status': 0,
    'Create time': 0,
  }.obs;
  List<String> ticketTypeList = ['All Type', 'PURCHASE', 'BREEDING'];
  late RxString selectedTicketType;
  RxList<TicketModel> ticketList = <TicketModel>[].obs;

  TicketManagementPageController() {
    selectedTicketType = ticketTypeList[0].obs;
  }
  setHeaderFilter(String headerKey) {
    petManagementTableHeaders.forEach((key, value) {
      if (key == headerKey) {
        if (value != 2) {
          petManagementTableHeaders[key] = petManagementTableHeaders[key]! + 1;
        } else {
          petManagementTableHeaders[key] = 0;
        }
      } else {
        petManagementTableHeaders[key] = 0;
      }
    });
  }
}
