import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/user.dart';

class UserService {
  final UserRepository userRepository;

  UserService({required this.userRepository});

  Future<User> getUser(int id) async {
    return await userRepository.getUser(id);
  }

  Future<List<User>> getAllUsers() async {
    return await userRepository.getAllUsers();
  }
}
