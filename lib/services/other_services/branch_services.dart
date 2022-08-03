import 'dart:convert';
import 'dart:io';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:http/http.dart' as http;

class BranchServices {
  static List<BranchModel> getBranchList(Map<String, dynamic> jsonData) {
    final branchListJson = jsonData['data'] as List;
    final List<BranchModel> branchList = List.empty(growable: true);
    for (var element in branchListJson) {
      branchList.add(BranchModel.fromJson(element));
    }
    return branchList;
  }

  static Future<List<BranchModel>> fetchBranchList({
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/branches'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getBranchList(jsonDecode(response.body));
      default:
        throw Exception('Error ${response.statusCode}, cannot get branch list');
    }
  }
}
