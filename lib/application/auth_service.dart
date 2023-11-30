import 'package:flutter_application/data/auth_repository.dart';
import 'package:flutter_application/domain/user_login.dart';

class AuthService {
  final AuthRepository authRepository;

  AuthService({required this.authRepository});

  Future<bool> login(UserLogin user) async {
    return await authRepository.login(user);
  }

  Future<void>logout() async {
    return await authRepository.logout();
  }

}
