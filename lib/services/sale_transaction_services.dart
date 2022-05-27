import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/configs/path.dart';

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

  static Future<int> createSaleTransaction({
    required DateTime createdTime,
    required DateTime meetingTime,
    required String placeMeeting,
    required int sellerReceive,
    required int transactionFee,
    required int transactionTotal,
    required String? description,
    String status = 'CREATED',
    required int buyerId,
    required int sellerId,
    required int petId,
    required int posId,
    int point = 0,
  }) async {
    final response = await http.post(
      Uri.http(API_SERVER, '/v1/api/sale-transactions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'createdTime': createdTime.toIso8601String(),
        'meetingTime': meetingTime.toIso8601String(),
        'placeMeeting': placeMeeting,
        'sellerReceive': sellerReceive,
        'transactionFee': transactionFee,
        'transactionTotal': transactionTotal,
        'description': description ?? '',
        'status': status,
        'buyerId': buyerId,
        'sellerId': sellerId,
        'petId': petId,
        'postId': posId,
        'point': point,
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        // return jsonDecode(response.body)['data']['id'];
        return json.decode(response.body)['data']['id'];
      default:
        print(response.body);
        throw Exception(
            'Error ${response.statusCode}, cannot create transaction');
    }
  }

  static Future<String> payment({
    required int id,
    required DateTime transactionTime,
    required int transactionTotal,
    required String paymentMethod,
    String? message,
    required String locale,
  }) async {
    final queryParameters = {
      'message': message ?? '',
      'locale': locale,
      'returnUrl': 'http://$API_SERVER$SALE_TRANSACTION_RETURN_PATH'
    };

    final response = await http.post(
      Uri.http(API_SERVER, 'v1/api/sale-transactions/payment', queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'transactionTime': transactionTime.toIso8601String(),
        'transactionTotal': transactionTotal,
        'paymentMethod': paymentMethod,
        'point': transactionTotal ~/ 1000
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        print(jsonDecode(response.body));
        return jsonDecode(response.body)['data']['url'];
      default:
        print(response.body);
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }
}
