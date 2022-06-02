import 'package:dio/dio.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/media_model/media_model.dart';
import 'dart:io';

import 'package:petapp_mobile/models/post_model/post_model.dart';

class PostService {
  static List<PostModel> getPostList(Map<String, dynamic> jsonData) {
    final postListJson = jsonData['post'] as List;
    final List<PostModel> postList = List.empty(growable: true);
    for (var element in postListJson) {
      postList.add(PostModel.fromJson(element));
    }
    return postList;
  }

  static Future updatePost({
    required int id,
    required String type,
    String? description,
    String status = 'REQUESTED',
    required String title,
    required List<MediaModel> mediaModels,
    required int sellerReceive,
    required int shopFee,
    required int provisionalTotal,
    required int deposits,
    required DateTime createTime,
    required DateTime meetingTime,
    required int petId,
    required int customerId,
    required int branchId,
    required List<int> deletedIds,
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'id': id,
        'title': title,
        'sellerReceive': sellerReceive,
        'shopFee': shopFee,
        'provisionalTotal': provisionalTotal,
        'createTime': createTime,
        'meetingTime': meetingTime,
        'type': type,
        'description': description ?? '',
        'status': status,
        'petId': petId,
        'customerId': customerId,
        'branchId': branchId,
        'deletedIds': deletedIds,
      });
      for (var element in mediaModels) {
        if (element.id == null) {
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(element.url),
            ),
          );
        }
      }
      Response response =
          await Dio().put('http://$API_SERVER_PATH/v1/api/posts',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
              }));

      return response.statusCode;
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.data);
      return e.response!.statusCode;
    }
  }

  static Future createPost({
    required String title,
    required int sellerReceive,
    required int shopFee,
    required int provisionalTotal,
    required int deposits,
    String? description,
    required DateTime createTime,
    required DateTime meetingTime,
    required String type,
    String status = 'PUBLISHED',
    required int petId,
    required int customerId,
    required List<String> filesPath,
    required int branchId,
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'title': title,
        'sellerReceive': sellerReceive,
        'shopFee': shopFee,
        'provisionalTotal': provisionalTotal,
        'createTime': createTime,
        'meetingTime': meetingTime,
        'type': type,
        'description': description ?? '',
        'status': status,
        'petId': petId,
        'customerId': customerId,
        'branchId': branchId
      });
      for (var element in filesPath) {
        formData.files.add(
          MapEntry(
            'files',
            await MultipartFile.fromFile(element),
          ),
        );
      }
      Response response =
          await Dio().post('http://$API_SERVER_PATH/v1/api/posts',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
              }));

      return response.statusCode;
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.data);
      return e.response!.statusCode;
    }
  }
}
