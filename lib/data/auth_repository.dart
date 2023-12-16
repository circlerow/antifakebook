import 'dart:convert';

import 'package:flutter_application/domain/user_login.dart';
import 'package:flutter_application/domain/user_signup.dart';
import 'package:flutter_application/domain/verify_code.dart';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/change_info_after_signup.dart';

abstract class AuthRepository {
  Future<bool> login(UserLogin user);
  Future<void> logout();
  Future<bool> signUp(UserSignup user);
  Future<bool> verifyCode(VerifyCode code);
  Future<bool> changeInfoAfterSignUp(InfoAfter infoAfter);
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login(UserLogin user) async {
    final http.Response response =
        await request('/login', 'POST', isToken: false, body: user.toJson());
    Map<String, dynamic> data = json.decode(response.body);
    print(data);
    if (data["code"] == "1000") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", data["data"]["token"]);
      prefs.setString("user_id", data["data"]["id"]);
      return true;
    }
    return false;
  }

  @override
  Future<bool> signUp(UserSignup user) async {
    final http.Response response =
        await request('/signup', 'POST', isToken: false, body: user.toJson());
    print('object');
    print(json.decode(response.body));
    Map<String, dynamic> data = json.decode(response.body);
    if (data["code"] == "1000") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", user.email);
      prefs.setString("verify_code", data["data"]["verify_code"]);

      VerifyCode verifyCodeObject = VerifyCode(
        email: user.email,
        verifyCode: prefs.getString("verify_code")!,
      );
      bool verificationResult = await verifyCode(verifyCodeObject);
      await login(UserLogin(
          email: user.email, password: user.password, uuid: 'string'));
      return verificationResult;
    }
    return false;
  }

  @override
  Future<bool> verifyCode(VerifyCode code) async {
    final http.Response response = await request('/check_verify_code', 'POST',
        isToken: false, body: code.toJson());
    Map<String, dynamic> data = json.decode(response.body);
    if (data["code"] == "1000") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user_id", data["data"]["id"]);
      return true;
    }
    return false;
  }

  @override
  Future<bool> changeInfoAfterSignUp(InfoAfter infoAfter) async {
    final http.StreamedResponse response = await multipartRequest(
        '/change_profile_after_signup', 'POST',
        isToken: true, infoAfter: infoAfter);
    Map<String, dynamic> data =
        json.decode(await response.stream.bytesToString());
    if (data["code"] == "1000") {
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    await request('/logout', 'POST', isToken: true);
  }
}
