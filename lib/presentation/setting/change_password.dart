import 'package:flutter/material.dart';
import 'package:flutter_application/domain/setting.dart';

import '../../application/setting_service.dart';
import '../../data/setting_repository.dart';
import '../login/login.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final SettingService settingService =
      SettingService(settingRepository: SettingRepositoryImpl());
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.facebook,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Đổi mật khẩu',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Mật khẩu cũ',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Mật khẩu mới',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Xác thực mâk khẩu',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _handleChangePasswordButtonPressed();
              },
              child: const Text('Đổi mật khẩu'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleChangePasswordButtonPressed() async {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      _showErrorDialog('Mật khẩu mới và xác nhận mật khẩu không khớp');
      return;
    }

    ChangePassWord changePassWord = ChangePassWord(
      password: oldPassword,
      newPassword: newPassword,
    );

    dynamic result = await settingService.changePassword(changePassWord);

    if (result["code"] == "1003") {
      _showErrorDialog('Mật khẩu cũ không chinh xác');
    }

    if (result["code"] == "9990") {
      _showErrorDialog('Mật khẩu cũ không chinh xác');
    }

    if (result["code"] == "1000") {
      _showErrorDialog('Đổi mật khẩu thành công, vui lòng đăng nhập lại');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
