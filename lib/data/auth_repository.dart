import 'dart:convert';

import 'package:flutter_application/domain/user_login.dart';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future<bool> login(UserLogin user);
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login(UserLogin user) async {
    final http.Response response = await request('/login', 'POST', isToken: false, body:user.toJson());
    Map<String, dynamic> data = json.decode(response.body);
    if(data["code"] == "1000") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", data["data"]["token"]);
      prefs.setString("user_id", data["data"]["id"]);
      return true;}
    return false;
  }

  @override
  Future<void> logout() async {
    await request('/logout', 'POST', isToken: true);
  }

}
