import 'dart:convert';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

abstract class FriendRepository {
  Future<dynamic> getRequestedFriends(dynamic body);
  Future<dynamic> getSuggestedFriends(dynamic body);
  Future<dynamic> setRequestFriend(String userId);
}

class FriendRepositoryImpl implements FriendRepository {
  @override
  Future<dynamic> getRequestedFriends(dynamic body) async {
    final http.Response response = await request('/get_requested_friends', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
  
  @override
    Future<dynamic> getSuggestedFriends(dynamic body) async {
    final http.Response response = await request('/get_suggested_friends', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  @override
  Future<dynamic> setRequestFriend(String userId) async {
    final http.Response response = await request('/set_request_friend', 'POST', isToken: true, body: jsonEncode({"user_id": userId}));
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}
