import 'dart:convert';

import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/shared/local.dart';
import 'package:flutter_application/shared/request.dart';

abstract class UserRepository {
  Future<User> getUser(int id);
  Future<List<User>> getAllUsers();
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<User> getUser(int id) async {
    final response = await request('/users/$id', 'GET');
    if (response.statusCode == 200) {
      return User.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    final response = await request('/users', 'GET');
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => User.fromMap(model)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
