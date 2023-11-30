import 'dart:convert';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<dynamic> getUserInfo(String userId);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<dynamic> getUserInfo(String userId) async {
    final http.Response response = await request('/get_user_info', 'POST', isToken: true, body: jsonEncode({"id" : userId}));
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

}
