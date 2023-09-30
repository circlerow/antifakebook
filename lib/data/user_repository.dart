import 'package:flutter_application/domain/user.dart';

abstract class UserRepository {
  Future<User> getUser(int id);
  Future<List<User>> getAllUsers();
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<User> getUser(int id) async {
    // TODO: Implement getUser
    // You can fetch the user data from a local database or a remote API here.
    // For now, let's return a dummy user.
    return User(id: id, name: 'Dummy User', email: 'dummy@example.com');
  }

  @override
  Future<List<User>> getAllUsers() async {
    // TODO: Implement getAllUsers
    // You can fetch all users data from a local database or a remote API here.
    // For now, let's return a list of dummy users.
    return List<User>.generate(
      10,
      (index) => User(
          id: index,
          name: 'Dummy User $index',
          email: 'dummy$index@example.com'),
    );
  }
}
