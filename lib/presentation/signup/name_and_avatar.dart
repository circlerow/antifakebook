import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/domain/change_info_after_signup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../application/auth_service.dart';
import '../../data/auth_repository.dart';
import 'signup_successful.dart';

class NameAndAvatarScreen extends StatefulWidget {
  const NameAndAvatarScreen({Key? key}) : super(key: key);

  @override
  _NameAndAvatarScreenState createState() => _NameAndAvatarScreenState();
}

class _NameAndAvatarScreenState extends State<NameAndAvatarScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _avatar;
  final AuthService authService =
      AuthService(authRepository: AuthRepositoryImpl());
  bool _loading = false;
  String? _validateName(String value) {
    SharedPreferences.getInstance().then((prefs) {
      String email = prefs.getString('email') ?? '';
    });
    if (value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Mật khẩu không được chứa ký tự đặc biệt';
    }
    if (value == 'example@example.com') {
      return 'Mật khẩu không được trùng với email';
    }
    if (value.length < 6 || value.length > 20) {
      return 'Mật khẩu phải có từ 6 đến 20 ký tự';
    }
    return null;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
      }
    });
  }

  Future<void> _changeInfoAfterSignUp() async {
    // Set loading state
    setState(() {
      _loading = true;
    });

    bool isChangeInfoAfterSignUp = await authService.changeInfoAfterSignUp(
      InfoAfter(
        userName: _nameController.text,
        avatar: _avatar,
      ),
    );

    // Reset loading state
    setState(() {
      _loading = false;
    });

    if (isChangeInfoAfterSignUp) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegistrationSuccessScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  const Icon(
                    Icons.facebook,
                    size: 100,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Đặt tên và ảnh đại diện',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Tên',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập tên';
                      } else if (_validateName(value) != null) {
                        return _validateName(value);
                      }
                      return null;
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_avatar != null)
                        Image.file(
                          _avatar!,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Chọn ảnh'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        readOnly: true,
                        controller:
                            TextEditingController(text: _avatar?.path ?? ''),
                        decoration:
                            const InputDecoration(labelText: 'Đường dẫn ảnh'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _changeInfoAfterSignUp();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "Cập nhật thông tin",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_loading)
            // Loading indicator
            const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
