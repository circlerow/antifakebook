import 'dart:io';

import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  static late User user;
  static late String fileAvatar;
  static late String fileBackGr;
  static late Future initState;
  static bool needUpdated = false;

  UserService userService = UserService(userRepository: UserRepositoryImpl());

  UserController() {
    initState = init();
  }

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id')!;
    User fetchedUser = await userService.getUserInfo(userId);
    user = fetchedUser;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String extensionAvatar = getExtensionFromUrl(fetchedUser.avatar);
    fileAvatar = '$tempPath/avatar_image.$extensionAvatar';
    String extensionBackGr = getExtensionFromUrl(fetchedUser.avatar);
    fileBackGr = '$tempPath/cover_image.$extensionBackGr';
    http.Response avatarHttp = await http.get(Uri.parse(fetchedUser
            .avatar.isNotEmpty
        ? fetchedUser.avatar
        : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"));

    await File(fileAvatar).writeAsBytes(avatarHttp.bodyBytes);
    http.Response backgrHttp = await http.get(Uri.parse(fetchedUser
            .coverImage.isNotEmpty
        ? fetchedUser.coverImage
        : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"));
    await File(fileBackGr).writeAsBytes(backgrHttp.bodyBytes);
  }

  String getExtensionFromUrl(String url) {
    int index = url.lastIndexOf('.');
    return index != -1 ? url.substring(index + 1) : '';
  }

  void update() {
    initState = init();
    return;
  }

  static Future<String> getAvatar() async {
    await Future.wait([initState]);
    return fileAvatar;
  }

  static Future<String> getUsername() async {
    await Future.wait([initState]);
    return user.username;
  }

  static Future<User> getUser() async {
    await Future.wait([initState]);
    return user;
  }

  static Future<void> setAvatar(File newAvatar) async {
    await File(fileAvatar).writeAsBytes(newAvatar.readAsBytesSync());
  }

  static Future<void> setBackGr(File backGr) async {
    await File(fileBackGr).writeAsBytes(backGr.readAsBytesSync());
  }

  static void updatedInfo(User newUser) {
    user = newUser;
  }
}
