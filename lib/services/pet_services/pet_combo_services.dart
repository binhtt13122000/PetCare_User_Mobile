import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/pet_combo_model/pet_combo_model.dart';

class PetComboServices {
  static List<PetComboModel> getPetComboList(List<dynamic> jsonData) {
    final List<PetComboModel> petComboList = List.empty(growable: true);
    for (var element in jsonData) {
      petComboList.add(PetComboModel.fromJson(element));
    }
    return petComboList;
  }

  static Future<List<PetComboModel>> fetchListPetComboByPetId({
    required int petId,
  }) async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH, '$PET_COMBO_API_PATH/pet/$petId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getPetComboList(json.decode(response.body)['data']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot get pet combo list');
    }
  }

  static Future<PetComboModel> fetchPetComboById({
    required String petComboId,
  }) async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH, '$PET_COMBO_API_PATH/$petComboId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return PetComboModel.fromJson(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet combo');
    }
  }

  static Future<bool> quickPayment({
    required DateTime registerTime,
    required int orderTotal,
    required int branchId,
    required int comboId,
    required int petId,
    required int breedingTransactionId,
    required int point,
    String paymentMethod = 'VNPAY',
    required DateTime dateOfBreeding,
  }) async {
    final response = await http.post(
      Uri.http(
        API_SERVER_PATH,
        PET_COMBO_PAYMENT_API_PATH,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'registerTime': registerTime.toIso8601String(),
        'orderTotal': orderTotal,
        'branchId': branchId,
        'comboId': comboId,
        'petId': petId,
        'breedingTransactionId': breedingTransactionId,
        'point': point,
        'paymentMethod': paymentMethod,
        'dateOfBreeding': dateOfBreeding.toIso8601String(),
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['success'];
      default:
        print(response.body);
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }

  static Future<String> payment({
    required String message,
    required String locale,
    required String paymentMethod,
    required int comboId,
    required int orderTotal,
    required DateTime paymentTime,
    required DateTime registerTime,
    // int? promotionId,
    // int? paymentPoint,
    //required int provisionalTotal,
    required int branchId,
    required int customerId,
    required int petId,
  }) async {
    final queryParameters = {
      'message': message,
      'locale': locale,
      'returnUrl': 'http://$API_SERVER_PATH$PET_COMBO_RETURN_API_PATH'
    };

    final response = await http.post(
      Uri.http(API_SERVER_PATH, PET_COMBO_API_PATH, queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'orderTotal': orderTotal,
        'branchId': branchId,
        'customerId': customerId,
        'point': orderTotal ~/ 1000,
        'paymentTime': paymentTime.toIso8601String(),
        'paymentMethod': paymentMethod,
        'comboId': comboId,
        "petId": petId,
        'registerTime': registerTime.toIso8601String(),
      }),
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
}
