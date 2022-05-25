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

  static Future<String> createSaleTransaction({
    required DateTime meetingTime,
    required String placeMeeting,
    required int sellerReceive,
    required int transactionFee,
    required int provisionalTotal,
    required int transactionTotal,
    required String? description,
    String status = 'CREATED',
    required int buyerId,
    required int sellerId,
    required int petId,
    required int posId,
  }) async {
    final response = await http.post(
      Uri.http(API_SERVER, '/v1/api/sale-transactions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'meetingTime': meetingTime.toIso8601String(),
        'placeMeeting': placeMeeting,
        'sellerReceive': sellerReceive,
        'transactionFee': transactionFee,
        'provisionalTotal': provisionalTotal,
        'transactionTotal': transactionTotal,
        'description': description ?? '',
        'status': status,
        'buyerId': buyerId,
        'sellerId': sellerId,
        'petId': petId,
        'postId': posId
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body).toString();
      default:
        print(response.body);
        throw Exception(
            'Error ${response.statusCode}, cannot create transaction');
    }
  }

  static Future<String> payment({
    required int id,
    required DateTime meetingTime,
    required String placeMeeting,
    required DateTime transactionTime,
    required int discount,
    required int transactionTotal,
    String? description,
    String? paymentMethod,
    required int star,
    required String? review,
    required String? reasonCancel,
    required String status,
    int? promotionId,
    String? message,
    required String locale,
    required String returnUrl,
  }) async {
    final queryParameters = {
      'message': message,
      'locale': locale,
      'returnUrl': 'http://$API_SERVER/v1/api/sale-transactions/vnpay_return'
    };

    final response = await http.post(
      Uri.http(API_SERVER, 'v1/api/sale-transactions/payment', queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'meetingTime': meetingTime.toIso8601String(),
        'placeMeeting': placeMeeting,
        'transactionTime': transactionTime.toIso8601String(),
        'discount': discount,
        'transactionTotal': transactionTotal,
        'description': description ?? '',
        'paymentMethod': paymentMethod ?? '',
        'star': star,
        'review': review ?? '',
        'reasonCancel': reasonCancel ?? '',
        'status': status,
        'message': message ?? '',
        'locale': locale,
        'returnUrl': returnUrl,
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['url'];
      default:
        print(response.body);
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }
}
