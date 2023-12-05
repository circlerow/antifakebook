import 'dart:convert';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

abstract class FriendRepository {
  Future<dynamic> getUserFriends(String index, String count, String userId);
  Future<dynamic> getRequestedFriends(dynamic body);
  Future<dynamic> getSuggestedFriends(dynamic body);
  Future<dynamic> setRequestFriend(String userId);
  Future<dynamic> setAcceptFriend(String userId, String isAccept);
}

class FriendRepositoryImpl implements FriendRepository {
  @override
  Future<dynamic> getUserFriends(String index, String count, String userId) async {
    final http.Response response = await request('/get_user_friends', 'POST', isToken: true, body: {"index" : index, "count": count, "user_id": userId});
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

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
    final http.Response response = await request('/set_request_friend', 'POST', isToken: true, body: ({"user_id" : userId}));
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  @override
  Future<dynamic> setAcceptFriend(String userId, String isAccept) async {
    final http.Response response = await request('/set_accept_friend', 'POST', isToken: true, body: {"user_id" : userId , "is_accept": isAccept});
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}
