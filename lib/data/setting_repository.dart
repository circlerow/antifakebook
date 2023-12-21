import 'dart:convert';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

import '../domain/setting.dart';

abstract class SettingRepository {
  Future<dynamic> depositCoin(String amount);
  Future<dynamic> getPushSetting();
  Future<dynamic> setPushSetting(PushSetting pushSetting);
  Future<dynamic> changePassword(ChangePassWord changePassWord);
  Future<void> setDevToken(String token);
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

  @override
  Future<dynamic> getPushSetting() async {
    final http.Response response =
        await request('/get_push_settings', 'POST', isToken: true);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  @override
  Future<dynamic> setPushSetting(PushSetting pushSetting) async {
    var body = {
      "like_comment": pushSetting.likeComment,
      "from_friends": pushSetting.fromFriends,
      "requested_friend": pushSetting.requestedFriend,
      "suggested_friend": pushSetting.suggestedFriend,
      "birthday": pushSetting.birthday,
      "video": pushSetting.video,
      "report": pushSetting.report,
      "sound_on": pushSetting.soundOn,
      "notification_on": pushSetting.notificationOn,
      "vibrant_on": pushSetting.vibrantOn,
      "led_on": pushSetting.ledOn
    };
    final http.Response response =
        await request('/set_push_settings', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  @override
  Future<dynamic> changePassword(ChangePassWord changePassWord) async {
    var body = {
      "password": changePassWord.password,
      "new_password": changePassWord.newPassword
    };
    final http.Response response =
        await request('/change_password', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<void> setDevToken(String token) async {
    var body = {"devtype": "1", "devtoken": token};
    final http.Response response =
        await request('/set_devtoken', 'POST', isToken: true, body: body);
  }
}
