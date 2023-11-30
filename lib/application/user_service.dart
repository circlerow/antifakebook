import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/user.dart';

class UserService {
  final UserRepository userRepository;

  UserService({required this.userRepository});

  Future<User> getUserInfo(String userId) async {
    final data =  await userRepository.getUserInfo(userId);
    dynamic user = data['data'];
    return User.fromJson(user);
  }
}
