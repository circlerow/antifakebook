import 'package:flutter_application/data/friend_repository.dart';
import 'package:flutter_application/domain/friend.dart';

class FriendService {
  final FriendRepository friendRepository;

  FriendService({required this.friendRepository});

  Future<Map<String, dynamic>> getUserFriends(String index, String count, String userId) async {
    dynamic res = await friendRepository.getUserFriends(index, count, userId);
    Map<String, dynamic> data = res["data"];
    List<dynamic> friendsJson = data['friends'] ?? [];
    List<Friend> friends = friendsJson.map((postJson) => Friend.fromJson(postJson)).toList();
    Map<String, dynamic> result = <String, dynamic>{};
    result["total"] = data["total"];
    result["friends"] = friends;
    return result;
  }

  Future<Map<String, dynamic>> getRequestedFriends(dynamic body) async {
    dynamic res =  await friendRepository.getRequestedFriends(body);
    Map<String, dynamic> data = res["data"];
    List<dynamic> friendsJson = data['requests'] ?? [];
    List<Friend> friends = friendsJson.map((postJson) => Friend.fromJson(postJson)).toList();
    Map<String, dynamic> result = <String, dynamic>{};
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
    return false;
  }

  Future<bool> setAcceptFriend(String userId, String isAccept) async {
    dynamic res = await friendRepository.setAcceptFriend(userId, isAccept);
    if(res['code'] == "1000")return true;
    return false;
  }

  Future<bool> unFriend(String userId) async {
    dynamic res = await friendRepository.unFriend(userId);
    if(res['code'] == "1000")return true;
    return false;
  }

  Future<bool> delRequestFriend(String userId) async {
    dynamic res = await friendRepository.delRequestFriend(userId);
    if(res['code'] == "1000")return true;
    return false;
  }

  Future<bool> blockFriend(String userId) async {
    dynamic res = await friendRepository.blockFriend(userId);
    if(res['code'] == "1000")return true;
    return false;
  }

  Future<List<Block>> listBlock(dynamic body) async {
    dynamic res = await friendRepository.listBlock(body);
    List<dynamic> listBlock = res['data'] ?? [];
    return listBlock.map((postJson) => Block.fromJson(postJson)).toList();
  }

  Future<bool> unBlockFriend(String userId) async {
    dynamic res = await friendRepository.unBlockFriend(userId);
    if(res['code'] == "1000")return true;
    return false;
  }

}
