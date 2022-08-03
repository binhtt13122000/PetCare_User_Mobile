import 'dart:convert';
import 'dart:io';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';
import 'package:http/http.dart' as http;

class TicketServices {
  static Future<int?> createTicket({
    required DateTime createdTime,
    required DateTime meetingDate,
    required int startTime,
    required int endTime,
    required int branchId,
    required int customerId,
    required List<int> servicesIdList,
    required String type,
    required String jwt,
  }) async {
    List<Map<String, int>> servicesIdJsonList = [];
    for (var element in servicesIdList) {
      servicesIdJsonList.add({'serviceId': element});
    }

    String jsonBody = jsonEncode({
      'createdTime': createdTime.toIso8601String(),
      'meetingDate': meetingDate
          .subtract(Duration(
            hours: meetingDate.hour,
            microseconds: meetingDate.microsecond,
            milliseconds: meetingDate.millisecond,
            minutes: meetingDate.minute,
            seconds: meetingDate.second,
          ))
          .toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'branchId': branchId,
      'customerId': customerId,
      'status': 'CREATED',
      'type': type,
      'serviceTickets': servicesIdJsonList,
    });
    final response = await http.post(
      Uri.https(API_SERVER_PATH, TICKET_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: jsonBody,
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['id'];
      default:
        return null;
    }
  }

  static Future<int?> updateTicket({
    required int ticketId,
    String? reasonCancel,
    required String jwt,
    required String status,
  }) async {
    String jsonBody = jsonEncode({
      'id': ticketId,
      'reasonCancel': reasonCancel,
      'status': status,
    });
    final response = await http.patch(
      Uri.https(API_SERVER_PATH, TICKET_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: jsonBody,
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['id'];
      default:
        return null;
    }
  }

  static Future<List<TicketModel>> fetchTicketListByBranch({
    required int branchId,
    required DateTime bookingTime,
    required String jwt,
  }) async {
    Map<String, dynamic> parameters = {
      'date': bookingTime
          .subtract(Duration(
            hours: bookingTime.hour,
            microseconds: bookingTime.microsecond,
            milliseconds: bookingTime.millisecond,
            minutes: bookingTime.minute,
            seconds: bookingTime.second,
          ))
          .toIso8601String()
    };
    final response = await http.get(
      Uri.https(
          API_SERVER_PATH, '$TICKET_BRANCHES_API_PATH/$branchId', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getTicketModelList(json.decode(response.body)['data']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot not get ticket list');
    }
  }

  static Future<TicketModel?> fetchTicketByCustomerId({
    required int customerId,
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '$TICKET_CUSTOMER_API_PATH/$customerId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return TicketModel.fromJson(json.decode(response.body)['data']);
      default:
        return null;
    }
  }

  static Future<TicketModel> fetchTicketById({
    required int ticketId,
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '$TICKET_API_PATH/$ticketId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return TicketModel.fromJson(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot not get ticket');
    }
  }

  static List<TicketModel> getTicketModelList(List<dynamic> jsonData) {
    final List<TicketModel> ticketList = [];
    for (var element in jsonData) {
      ticketList.add(TicketModel.fromJson(element));
    }
    return ticketList;
  }
}
