import 'package:dio/dio.dart';
import 'dart:io';

import 'package:petapp_mobile/models/post_model/post_model.dart';

class PostService {
  static PostModel getPost(Map<String, dynamic> jsonData) =>
      PostModel.fromJson(jsonData);

  static List<PostModel> getPostList(Map<String, dynamic> jsonData) {
    final postListJson = jsonData['post'] as List;
    final List<PostModel> postList = List.empty(growable: true);
    for (var element in postListJson) {
      postList.add(getPost(element));
    }
    return postList;
  }

  static Future createPost({
    required String title,
    required int price,
    required int deposit,
    required String refund,
    required DateTime effectiveTime,
    required String description,
    required String type,
    String status = 'PUBLISHED',
    required int petId,
    required int sellerId,
    required List<String> evidenceFilesPath,
    required List<String> healthCheckFilesPath,
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'title': title,
        'price': price,
        'deposit': deposit,
        'refund': refund,
        'effectiveTime': effectiveTime,
        'description': description,
        'type': type,
        'status': status,
        'petId': petId,
        'sellerId': sellerId,
        'staffId': sellerId,
        'approveTime': DateTime.now(),
        'cancelTime': DateTime.now(),
      });
      for (var element in evidenceFilesPath) {
        formData.files.add(
          MapEntry(
            'evidenceFiles',
            await MultipartFile.fromFile(element),
          ),
        );
      }

      for (var element in evidenceFilesPath) {
        formData.files.add(
          MapEntry(
            'healthCheckFiles',
            await MultipartFile.fromFile(element),
          ),
        );
      }

      Response response = await Dio().post('http://172.16.1.41:4000/posts',
          data: formData,
          options: Options(headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
          }));

      return response.statusCode;
    } on DioError catch (e) {
      print(e.error);
      return e.response!.statusCode;
    }
  }
}
