import 'dart:convert';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

abstract class NotificationRepository {
  Future<dynamic> getNotifications(dynamic body);
  Future<dynamic> setReadNotification(dynamic body);
}

class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<dynamic> getNotifications(dynamic body) async {
    final http.Response response =
        await request('/get_notification', 'POST', isToken: true, body: body);
   
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  @override
  Future<dynamic> setReadNotification(dynamic body) async {
    final http.Response response =
        await request('/get_notification', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}
