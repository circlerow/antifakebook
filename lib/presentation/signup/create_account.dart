// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application/domain/user_signup.dart';

import '../../application/auth_service.dart';
import '../../data/auth_repository.dart';
import 'verify_code.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final AuthService authService =
      AuthService(authRepository: AuthRepositoryImpl());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
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
                    'Đăng kí',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập email';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Địa chỉ email không hợp lệ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Mật khẩu',
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
                      hintText: 'Xác nhận mật khẩu',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng xác nhận mật khẩu';
                      } else if (value != _passwordController.text) {
                        return 'Mật khẩu xác nhận không khớp';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _loading = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        bool isSignup = await authService.signUp(UserSignup(
                            email: email, password: password, uuid: "string"));
                        setState(() {
                          _loading = false; // Ẩn màn hình loading khi xong
                        });
                        if (isSignup) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VerifyCodeScreen()),
                          );
                        }
                        if (!isSignup) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Email đã được sử dụng, vui lòng sử dụng email khác'),
                              backgroundColor:
                                  Colors.red, // Màu nền của SnackBar
                              action: SnackBarAction(
                                label: 'Đóng',
                                onPressed: () {
                                  // Xử lý khi nút "Đóng" được nhấn
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.only(
                                  bottom: 50,
                                  left: 20,
                                  right: 20), // Điều chỉnh vị trí xuất hiện
                            ),
                          );
                        }
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
                          "Đăng kí",
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
          Visibility(
            visible: _loading,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
