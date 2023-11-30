import 'package:flutter_application/data/friend_repository.dart';
import 'package:flutter_application/domain/friend.dart';

class FriendService {
  final FriendRepository friendRepository;

  FriendService({required this.friendRepository});

  Future<Map<String, dynamic>> getRequestedFriends(dynamic body) async {
    dynamic res =  await friendRepository.getRequestedFriends(body);
    Map<String, dynamic> data = res["data"];
    List<dynamic> friendsJson = data['requests'] ?? [];
    List<Friend> friends = friendsJson.map((postJson) => Friend.fromJson(postJson)).toList();
    Map<String, dynamic> result = new Map<String, dynamic>();
    result["total"] = data["total"];
    result["friends"] = friends;
    return result;
  }

  Future<List<Friend>> getSuggestedFriends(dynamic body) async {
    dynamic res = await friendRepository.getSuggestedFriends(body);
    List<dynamic> friendsJson = res['data'] ?? [];
    return friendsJson.map((postJson) => Friend.fromJson(postJson)).toList();
  }

  Future<bool> setRequestFriend(String userId) async {
    dynamic res = await friendRepository.setRequestFriend(userId);
    if(res['code'] == "1000")return true;
    else return false;
  }

}
