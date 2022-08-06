import 'dart:convert';
import 'dart:io';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';
import 'package:http/http.dart' as http;

class PromotionServices {
  static List<PromotionModel> getPromotionList(Map<String, dynamic> jsonData) {
    final promotionListJson = jsonData['data'] as List;
    final List<PromotionModel> promotionList = List.empty(growable: true);
    for (var element in promotionListJson) {
      promotionList.add(PromotionModel.fromJson(element));
    }
    return promotionList;
  }

  static Future<List<PromotionModel>> fetchPromotionByBranchId({
    required int branchId,
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/promotions/branches/$branchId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getPromotionList(json.decode(response.body));
      default:
        throw Exception('Error ${response.statusCode}, cannot get promotions');
    }
  }
}
