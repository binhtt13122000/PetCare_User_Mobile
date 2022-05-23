import 'package:petapp_mobile/models/normal_transaction_model/normal_transaction_model.dart';

class NormalTransactionServices {
  static NormalTransactionModel getNormalTransaction(
          Map<String, dynamic> jsonData) =>
      NormalTransactionModel.fromJson(jsonData);

  static List<NormalTransactionModel> getNormalTransactionList(
      Map<String, dynamic> jsonData) {
    final normalTransactionListJson = jsonData['order'] as List;
    final List<NormalTransactionModel> normalTransactionList =
        List.empty(growable: true);
    for (var element in normalTransactionListJson) {
      normalTransactionList.add(getNormalTransaction(element));
    }
    return normalTransactionList;
  }
}
