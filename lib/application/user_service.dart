import 'dart:io';

import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/user.dart';

class UserService {
  final UserRepository userRepository;

  UserService({required this.userRepository});

  Future<User> getUserInfo(String userId) async {
    final data = await userRepository.getUserInfo(userId);
    dynamic user = data['data'];
    return User.fromJson(user);
  }

  Future<void> setUserInfo(
      String username,
      String description,
      File avatar,
      String address,
      String city,
      String country,
      File cover,
      String link) async {
    final data = await userRepository.updateUserInfo(
        username, description, avatar, address, city, country, cover, link);
    //print("Data =" + data.toString());
  }

 

}
