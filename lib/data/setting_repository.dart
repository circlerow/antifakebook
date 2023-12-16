import 'dart:convert';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

abstract class SettingRepository {
  Future<dynamic> depositCoin(String amount);
}

class SettingRepositoryImpl implements SettingRepository {
  @override
  Future<dynamic> depositCoin(String amount) async {
    var body = {"code": "string", "coins": amount};
    final http.Response response =
        await request('/buy_coins', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}
