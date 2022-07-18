import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/configs/path.dart';

class SaleTransactionService {
  static SaleTransactionModel getSaleTransaction(
          Map<String, dynamic> jsonData) =>
      SaleTransactionModel.fromJson(jsonData);

  static List<SaleTransactionModel> getSaleTransactionList(
      List<dynamic> jsonData) {
    final List<SaleTransactionModel> saleTransactionList =
        List.empty(growable: true);
    for (var element in jsonData) {
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
    required int branchId,
  }) async {
    final response = await http.post(
      Uri.https(API_SERVER_PATH, '/v1/api/sale-transactions'),
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
        'branchId': branchId
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        if (json.decode(response.body)['data']['isSuccess']) {
          return json.decode(response.body)['data']['id'];
        } else {
          return -1;
        }
      default:
        return -1;
    }
  }

  static Future<int> updateSaleTransaction({
    required int id,
    required DateTime meetingTime,
    required String placeMeeting,
    DateTime? transactionTime,
    int star = 0,
    String? review,
    String? reasonCancel,
    required String status,
    int point = 0,
    DateTime? cancelTime,
    String? message,
  }) async {
    final response = await http.put(
      Uri.https(API_SERVER_PATH, SALE_TRANSACTION_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'meetingTime': meetingTime.toIso8601String(),
        'placeMeeting': placeMeeting,
        'transactionTime': transactionTime?.toIso8601String(),
        'review': review ?? '',
        'reasonCancel': reasonCancel ?? '',
        'status': status,
        'point': point,
        'cancelTime': cancelTime?.toIso8601String(),
        'message': message,
        'star': star
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body)['data']['id'];
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot update transaction');
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
      'returnUrl': 'http://$API_SERVER_PATH$SALE_TRANSACTION_RETURN_API_PATH'
    };
    String jsonBody = jsonEncode({
      'id': id,
      'transactionTime': transactionTime.toIso8601String(),
      'transactionTotal': transactionTotal,
      'paymentMethod': paymentMethod,
      'point': transactionTotal ~/ 1000,
      'message': 'Thank for your payment!'
    });
    final response = await http.post(
      Uri.https(
          API_SERVER_PATH, 'v1/api/sale-transactions/payment', queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['url'];
      default:
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }

  static Future<List<SaleTransactionModel>> fetchSaleTransactionList({
    required String? buyerId,
    required String? sellerId,
    required String page,
    required String limit,
  }) async {
    final Map<String, dynamic> parameters = <String, dynamic>{
      'buyerId': buyerId,
      'sellerId': sellerId,
      'page': page,
      'limit': limit,
    };
    final response = await http.get(
      Uri.https(API_SERVER_PATH, SALE_TRANSACTION_API_PATH, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getSaleTransactionList(
            json.decode(response.body)['data'] as List);
      default:
        throw Exception('Error ${response.statusCode}, cannot login');
    }
  }

  static Future<SaleTransactionModel> fetchSaleTransactionById({
    required int saleTransactionId,
  }) async {
    final response = await http.get(
      Uri.https(
          API_SERVER_PATH, '$SALE_TRANSACTION_API_PATH/$saleTransactionId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return SaleTransactionModel.fromJson(
            json.decode(response.body)['data']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot get sale transaction');
    }
  }
}
