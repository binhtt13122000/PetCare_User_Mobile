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

  static Future<int> createBreedingTransaction({
    required DateTime createdTime,
    required String placeMeeting,
    required DateTime meetingTime,
    required int sellerReceive,
    required int transactionTotal,
    int point = 0,
    String description = '',
    String status = 'CREATED',
    required int ownerPetMaleId,
    required int ownerPetFemaleId,
    required int petMaleId,
    required int petFemaleId,
    required int postId,
    required int branchId,
    required int transactionFee,
    bool isSelf = false,
  }) async {
    final response = await http.post(
      Uri.http(API_SERVER_PATH, BREEDING_TRANSACTION_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'createdTime': createdTime.toIso8601String(),
        'meetingTime': meetingTime.toIso8601String(),
        'sellerReceive': sellerReceive,
        'transactionTotal': transactionTotal,
        'point': point,
        'description': description,
        'status': status,
        'ownerPetFemaleId': ownerPetFemaleId,
        'ownerPetMaleId': ownerPetMaleId,
        'petFemaleId': petFemaleId,
        'petMaleId': petMaleId,
        'postId': postId,
        'branchId': branchId,
        'transactionFee': transactionFee,
        'placeMeeting': placeMeeting,
        'self': isSelf
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        if (json.decode(response.body)['data']['isSuccess'] != null &&
            json.decode(response.body)['data']['isSuccess']) {
          return json.decode(response.body)['data']['id'];
        } else {
          return -1;
        }
      default:
        return -1;
    }
  }

  static Future<bool> bookingBreedingServices({
    required int breedingTransactionId,
    required int branchId,
    required DateTime bookingTime,
  }) async {
    final response = await http.post(
      Uri.http(API_SERVER_PATH, BREEDING_TRANSACTION_BOOKING_SERVICES_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': breedingTransactionId,
        'breedingBranchId': branchId,
        'dateOfBreeding': bookingTime.toIso8601String(),
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body)['success'];
      default:
        throw Exception('Error ${response.statusCode}, cannot send request');
    }
  }

  static Future<int> reviewForTransaction({
    required int id,
    required int star,
    required String review,
  }) async {
    final response = await http.put(
      Uri.http(API_SERVER_PATH,
          BREADING_TRANSACTION_REVIEW_FOR_TRANSACTION_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'id': id, 'review': review, 'star': star}),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body)['data']['id'];
      default:
        throw Exception('Error ${response.statusCode}, cannot send review');
    }
  }

  static Future<int> reviewForBranch({
    required int id,
    required int star,
    required String review,
  }) async {
    final response = await http.put(
      Uri.http(
          API_SERVER_PATH, BREADING_TRANSACTION_REVIEW_FOR_BRANCH_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'id': id, 'review': review, 'star': star}),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body)['data']['id'];
      default:
        throw Exception('Error ${response.statusCode}, cannot send review');
    }
  }

  static Future<String> quickPayment({
    required int id,
    required DateTime paymentForMalePetOwnerTime,
  }) async {
    String jsonBody = jsonEncode({
      'id': id,
      'paymentTime': paymentForMalePetOwnerTime.toIso8601String(),
    });
    final response = await http.post(
      Uri.http(
        API_SERVER_PATH,
        BREEDING_TRANSACTION_PAYMENT_FOR_PET_MALE_OWNER_API,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['status'];
      default:
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }

  static Future<String> quickPaymentForBranch({
    required int id,
    required DateTime paymentForBranchTime,
  }) async {
    String jsonBody = jsonEncode({
      'id': id,
      'paymentTime': paymentForBranchTime.toIso8601String(),
      'pickupFemalePetTime': paymentForBranchTime.toIso8601String(),
    });
    final response = await http.put(
      Uri.http(
        API_SERVER_PATH,
        BREEDING_TRANSACTION_PAYMENT_FOR_BRANCH_API,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['status'];
      default:
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }

  static Future<String> pickUpMalePet({
    required int id,
    required DateTime pickupMalePetTime,
  }) async {
    String jsonBody = jsonEncode({
      'id': id,
      'pickupMalePetTime': pickupMalePetTime.toIso8601String(),
    });
    final response = await http.put(
      Uri.http(
        API_SERVER_PATH,
        BREEDING_TRANSACTION_PICKUP_MALE_PET_API,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['status'];
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot pick kup male pet');
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
      'returnUrl':
          'http://$API_SERVER_PATH$BREEDING_TRANSACTION_RETURN_API_PATH'
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
      Uri.http(API_SERVER_PATH, BREEDING_TRANSACTION_PAYMENT_API_PATH,
          queryParameters),
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

  static Future<bool> cancelTransaction({
    required int id,
    required String reasonCancel,
  }) async {
    final response = await http.put(
      Uri.http(API_SERVER_PATH, '$BREEDING_TRANSACTION_API_PATH/cancel'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'cancelTime': DateTime.now().toIso8601String(),
        'reasonCancel': reasonCancel,
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body)['success'];
      default:
        return false;
    }
  }

  static Future<bool> cancelBreeding({
    required int id,
    required String reasonCancel,
  }) async {
    final response = await http.put(
      Uri.http(API_SERVER_PATH, '$BREEDING_TRANSACTION_API_PATH/cancel-breed'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'cancelTime': DateTime.now().toIso8601String(),
        'reasonCancel': reasonCancel,
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body)['success'];
      default:
        return false;
    }
  }
}
