import 'package:flutter_application/data/auth_repository.dart';
import 'package:flutter_application/domain/user_login.dart';
import 'package:flutter_application/domain/user_signup.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../domain/change_info_after_signup.dart';

class AuthService {
  final AuthRepository authRepository;

  AuthService({required this.authRepository});

  Future<bool> login(UserLogin user) async {
    return await authRepository.login(user);
  }

  Future<void> logout() async {
    return await authRepository.logout();
  }

  Future<bool> signUp(UserSignup user) async {
    return await authRepository.signUp(user);
  }

  Future<bool> changeInfoAfterSignUp(InfoAfter infoAfter) async {
    return await authRepository.changeInfoAfterSignUp(infoAfter);
  }
}
