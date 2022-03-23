import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';
import 'package:petapp_mobile/models/services_model/services_model.dart';

class TransactionPageController extends GetxController {
  ValueNotifier<GraphQLClient> graphqlClient = GRAPHQL_CLIENT;

  List<ServiceModel> services = List.empty(growable: true);
  List<String> sorts = [
    'Recently transaction',
    'Price: Low → High',
    'Price: High → Low',
  ];
  late RxString selectedSort;
  late RxString selectedSevices;
  late RxList<SaleTransactionModel> saleTransactions;
  TransactionPageController() {
    selectedSort = sorts[0].obs;

    services.add(
      ServiceModel(
          id: 1,
          name: 'Purchase',
          imageUrl: IMAGE_PATH + HAND_SHAKE_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 4,
          name: 'Breeding',
          imageUrl: IMAGE_PATH + PET_BABY_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 2,
          name: 'Veterinary',
          imageUrl: IMAGE_PATH + VERTERINARIAN_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 3,
          name: 'Grooming',
          imageUrl: IMAGE_PATH + GROOMING_PNG,
          description: 'description',
          status: 1),
    );

    services.add(
      ServiceModel(
          id: 5,
          name: 'Traning',
          imageUrl: IMAGE_PATH + TRANING_PNG,
          description: 'description',
          status: 1),
    );
    selectedSevices = services[0].name.obs;
  }
}
