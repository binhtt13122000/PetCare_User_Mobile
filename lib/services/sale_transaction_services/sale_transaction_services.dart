import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';

class SaleTransactionService {
  static SaleTransactionModel getSaleTransaction(
          Map<String, dynamic> jsonData) =>
      SaleTransactionModel.fromJson(jsonData);

  static List<SaleTransactionModel> getSaleTransactionList(
      Map<String, dynamic> jsonData) {
    final saleTransactionListJson = jsonData['sale_transaction'] as List;
    final List<SaleTransactionModel> saleTransactionList =
        List.empty(growable: true);
    for (var element in saleTransactionListJson) {
      saleTransactionList.add(getSaleTransaction(element));
    }
    return saleTransactionList;
  }
}
