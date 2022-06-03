import 'package:petapp_mobile/models/breeding_transaction_model/breeding_transaction_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/configs/path.dart';

class BreedingTransactionService {
  static List<BreedingTransactionModel> getBreedTransactionList(
      List<dynamic> jsonData) {
    final List<BreedingTransactionModel> breedTransactionList =
        List.empty(growable: true);
    for (var element in jsonData) {
      breedTransactionList.add(BreedingTransactionModel.fromJson(element));
    }
    return breedTransactionList;
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
      Uri.http(API_SERVER_PATH, '/v1/api/sale-transactions'),
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
        return json.decode(response.body)['data']['id'];
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot create transaction');
    }
  }

  static Future<int> updateSaleTransaction({
    required int id,
    required DateTime meetingTime,
    required String placeMeeting,
    DateTime? transactionTime,
    required int transactionTotal,
    String? description,
    String? paymentMethod,
    int star = 0,
    String? review,
    String? reasonCancel,
    required String status,
    int point = 0,
    DateTime? cancelTime,
    String? message,
  }) async {
    final response = await http.put(
      Uri.http(API_SERVER_PATH, SALE_TRANSACTION_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'meetingTime': meetingTime.toIso8601String(),
        'placeMeeting': placeMeeting,
        'transactionTime': transactionTime?.toIso8601String(),
        'transactionTotal': transactionTotal,
        'description': description ?? '',
        'paymentMethod': paymentMethod ?? '',
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
      Uri.http(
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

  static Future<List<BreedingTransactionModel>> fetchBreedingTransactionList({
    required String? petOwnerFemaleId,
    required String? petOwnerMaleId,
    required String page,
    required String limit,
  }) async {
    final Map<String, dynamic> parameters = <String, dynamic>{
      'petOwnerFemaleId': petOwnerFemaleId,
      'petOwnerMaleId': petOwnerMaleId,
      'page': page,
      'limit': limit,
    };
    final response = await http.get(
      Uri.http(API_SERVER_PATH, BREEDING_TRANSACTION_API_PATH, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getBreedTransactionList(json.decode(response.body)['data']);
      default:
        // throw Exception('Error ${response.statusCode}, cannot get breeding transaction list');
        return [];
    }
  }

  static Future<BreedingTransactionModel> fetchBreedingTransactionById({
    required int breedingTransactionId,
  }) async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH,
          '$BREEDING_TRANSACTION_API_PATH/$breedingTransactionId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return BreedingTransactionModel.fromJson(
            json.decode(response.body)['data']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot get breeding transaction');
    }
  }
}
