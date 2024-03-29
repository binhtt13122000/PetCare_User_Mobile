import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/chat_room_model/chat_room_model.dart';
import 'package:petapp_mobile/models/message_model/message_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class ChatServices {
  static ChatRoomModel getChatRoomModel(Map<String, dynamic> jsonData) =>
      ChatRoomModel.fromJson(jsonData);

  static List<ChatRoomModel> getChatRoomModelList(
      Map<String, dynamic> jsonData) {
    final chatRoomModelListJson = jsonData['data'] as List;
    final List<ChatRoomModel> chatRoomModelList = List.empty(growable: true);
    for (var element in chatRoomModelListJson) {
      chatRoomModelList.add(getChatRoomModel(element));
    }
    return chatRoomModelList;
  }

  static Future<List<ChatRoomModel>> fetchChatRoomListByCustomerId({
    required int customerId,
    required String roomType,
    required String jwt,
  }) async {
    final Map<String, String> parameters = {'type': roomType};
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/rooms/user/$customerId', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getChatRoomModelList(jsonDecode(response.body));
      //return json.decode(response.body)['data'];
      default:
        throw Exception('Error ${response.statusCode}, cannot fetch');
    }
  }

  static Future<ChatRoomModel> fetchChatRoomById({
    required String chatRoomId,
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/rooms/$chatRoomId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getChatRoomModel(jsonDecode(response.body)['data']);

      //return json.decode(response.body)['data'];
      default:
        throw Exception('Error ${response.statusCode}, cannot fetch');
    }
  }

  static Future<String?> fetchChatRoomId({
    required int buyerId,
    required int postId,
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/rooms/buyer/$buyerId/post/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['_id'];
      default:
        return null;
    }
  }

  static Future<List<MessageModel>> fetchMessageListByChatRoomId({
    required String chatRoomId,
    required int skip,
    required int limit,
    required String jwt,
  }) async {
    Map<String, String> parameters = {
      'skip': skip.toString(),
      'limit': limit.toString(),
    };
    final response = await http.get(
      Uri.https(
          API_SERVER_PATH, '/v1/api/messages/room/$chatRoomId', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getMessageList(jsonDecode(response.body));
      //return json.decode(response.body)['data'];
      default:
        throw Exception('Error ${response.statusCode}, cannot fetch');
    }
  }

  static List<MessageModel> getMessageList(Map<String, dynamic> jsonData) {
    final messageListJson = jsonData['data'] as List;
    final List<MessageModel> messageList = List.empty(growable: true);
    for (var element in messageListJson) {
      messageList.add(MessageModel.fromJson(element));
    }
    return messageList;
  }

  static Future<String?> uploadMedia(
      {required String mediaFilePath, required String jwt}) async {
    try {
      FormData formData = FormData.fromMap({});
      formData.files.add(
        MapEntry(
          'file',
          await MultipartFile.fromFile(mediaFilePath),
        ),
      );
      Response response =
          await Dio().post('https://$API_SERVER_PATH/v1/api/messages/upload',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
                HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
              }));

      switch (response.statusCode) {
        case 200:
        case 201:
        case 202:
          return response.data['data']['url'];
        default:
      }
    } on DioError catch (_) {}
    return null;
  }
}
