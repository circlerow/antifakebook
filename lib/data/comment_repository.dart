import 'dart:convert';

import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  Future<dynamic> getMarkComment(dynamic body) async {
    final http.Response response =
        await request('/get_mark_comment', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);
    print(" DATA = " + data['code']);
    return data;
  }

  Future<dynamic> setMarkComment(dynamic body) async {
    final http.Response response =
        await request('/set_mark_comment', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);
    print(" DATA = " + data['code']);
    return data;
  }
}
