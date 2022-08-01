import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/media_model/media_model.dart';
import 'dart:io';

import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/post_model_hasura/post_model_hasura.dart';

class PostService {
  static List<PostModel> getPostList(Map<String, dynamic> jsonData) {
    final postListJson = jsonData['post'] as List;
    final List<PostModel> postList = List.empty(growable: true);
    for (var element in postListJson) {
      postList.add(PostModel.fromJson(element));
    }
    return postList;
  }

  static List<PostModelHasura> getPostHasuraList(
      Map<String, dynamic> jsonData) {
    final postListJson = jsonData['post'] as List;
    final List<PostModelHasura> postList = List.empty(growable: true);
    for (var element in postListJson) {
      postList.add(PostModelHasura.fromJson(element));
    }
    return postList;
  }

  static List<PostModel> getPostListByCustom(List<dynamic> jsonData) {
    final List<PostModel> postList = List.empty(growable: true);
    for (var element in jsonData) {
      postList.add(PostModel.fromJson(element));
    }
    return postList;
  }

  static Future<int?> updatePostStatusByPostId({
    required int postId,
    required String postStatus,
    required String jwt,
  }) async {
    final response = await http.patch(
      Uri.https(API_SERVER_PATH, POST_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: jsonEncode(
        {
          'id': postId,
          'status': postStatus,
          'reasonReject': null,
          'rejectTime': null,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body)['data']['id'];
      default:
        throw Exception('Error ${response.statusCode}, cannot cancel post');
    }
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
    required int transactionTotal,
    required int deposits,
    required DateTime createTime,
    required DateTime meetingTime,
    required int petId,
    required int customerId,
    required int branchId,
    required List<int> deletedIds,
    required String jwt,
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'id': id,
        'title': title,
        'sellerReceive': sellerReceive,
        'shopFee': shopFee,
        'transactionTotal': transactionTotal,
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
          await Dio().put('https://$API_SERVER_PATH/v1/api/posts',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
                HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
              }));

      return response.statusCode;
    } on DioError catch (e) {
      return e.response!.statusCode;
    }
  }

  static Future createPost({
    required String title,
    required int sellerReceive,
    required int shopFee,
    required int transactionTotal,
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
    required String jwt,
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'title': title,
        'sellerReceive': sellerReceive,
        'shopFee': shopFee,
        'transactionTotal': transactionTotal,
        'createTime': createTime,
        'meetingTime': meetingTime,
        'type': type,
        'description': description ?? '',
        'status': status,
        'petId': petId,
        'customerId': customerId,
        'branchId': branchId,
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
          await Dio().post('https://$API_SERVER_PATH$POST_API_PATH',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
                HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
              }));
      return response.statusCode;
    } on DioError catch (e) {
      return e.response!.statusCode;
    }
  }

  static Future<PostModel> fetchPostById({
    required int postId,
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/posts/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return PostModel.fromJson(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get species');
    }
  }

  static Future<List<PostModel>> fetchPostListByCustomerId({
    required int customerId,
    required int page,
    required int limit,
    String? type,
    required String jwt,
  }) async {
    Map<String, dynamic> parameters = {
      'page': page.toString(),
      'limit': limit.toString(),
      'orderName': 'createTime',
      'orderType': 'DESC',
      'customerId': customerId.toString(),
    };
    type != null && type.isNotEmpty ? parameters.addAll({'type': type}) : null;
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/posts/fetch-post', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getPostListByCustom(
            json.decode(response.body)['data']['content']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet list');
    }
  }

  static Future<List<PostModel>> fetchAllPurchasePostList({
    required int customerId,
    required String status,
    required int page,
    required int limit,
    required String jwt,
  }) async {
    Map<String, String> parameters = {
      'page': page.toString(),
      'limit': limit.toString(),
      'notCustomerId': customerId.toString(),
      'status': status,
    };
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/posts/fetch-post', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getPostListByCustom(
            json.decode(response.body)['data']['content']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get post');
    }
  }
}
