// ignore_for_file: non_constant_identifier_names, avoid_print
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';

class TicketServices {
  static TicketModel getTicket(Map<String, dynamic> jsonData) =>
      TicketModel.fromJson(jsonData);

  static List<TicketModel> getTicketList(Map<String, dynamic> jsonData) {
    final ticketListJson = jsonData['ticket'] as List;
    final List<TicketModel> ticketList = List.empty(growable: true);
    for (var element in ticketListJson) {
      ticketList.add(getTicket(element));
    }
    return ticketList;
  }

  static Future CREATE_TICKET({
    required String name,
    required String phoneNumber,
    required String type,
    required String title,
    required DateTime date,
    required String description,
    required DateTime meetingTime,
    String status = 'REQUESTED',
    required List<String> files,
    String evidence = '',
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'name': name,
        'phoneNumber': phoneNumber,
        'type': type,
        'title': title,
        'date': date,
        'description': description,
        'meetingTime': meetingTime,
        'status': status,
        'evidence': evidence,
      });

      for (var element in files) {
        formData.files
            .add(MapEntry('files', await MultipartFile.fromFile(element)));
      }

      Response response = await Dio().post("http://54.215.144.186:80/tickets",
          data: formData,
          options: Options(headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
          }));

      print(response.statusCode);
      return response.statusCode;
    } on DioError catch (e) {
      print(e.error);
      return e.response!.statusCode;
    }
  }
}
