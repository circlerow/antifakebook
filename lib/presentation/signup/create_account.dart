// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application/domain/user_signup.dart';
import 'package:flutter_application/presentation/login/login.dart';

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
  bool isUsernameEmpty = false;
  bool isPasswordEmpty = false;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  void signup() {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (!email.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(_emailController.text) &&
        password == confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Email đã được sử dụng',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Vui lòng sử dụng Email khác để có thể đăng ký.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Color.fromARGB(255, 6, 103, 223)),
              ),
            ),
          ],
        ),
      );
    }
  }

  final AuthService authService =
      AuthService(authRepository: AuthRepositoryImpl());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.pink.shade50,
                    Colors.purple.shade50,
                    Colors.blue.shade50,
                    Colors.white,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16.0, left: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate back to the login screen
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 8.0),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // logo
                          const Icon(
                            Icons.facebook,
                            size: 80,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'Đăng ký',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 27,
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          Container(
                            // margin: const EdgeInsets.only(top: 100.0),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 60,
                            padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0), // Khoảng cách nằm trong Container
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey[400]!), // Màu viền xám nhẹ
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 156, 160, 164)),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text(
                                        'Vui lòng nhập Email',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text(
                                          'Vui lòng nhập Email để đăng ký.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 6, 103, 223)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  isUsernameEmpty = true;
                                } else if (!RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text(
                                        'Địa chỉ Email không hợp lệ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text(
                                          'Vui lòng nhập đúng Email để đăng ký.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 6, 103, 223)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  isUsernameEmpty = true;
                                } else {
                                  isUsernameEmpty = false;
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 60,
                            padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0), // Khoảng cách nằm trong Container
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey[400]!), // Màu viền xám nhẹ
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Mật khẩu',
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 156, 160, 164)),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  if (isUsernameEmpty == false) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Text(
                                          'Vui lòng nhập mật khẩu',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Text(
                                            'Vui lòng nhập mật khẩu để đăng ký.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 6, 103, 223)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  isPasswordEmpty = true;
                                  return null;
                                }
                                isPasswordEmpty = false;
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 60,
                            padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0), // Khoảng cách nằm trong Container
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey[400]!), // Màu viền xám nhẹ
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                labelText: 'Nhập lại mật khẩu',
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 156, 160, 164)),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  if (_emailController.text.isEmpty == false &&
                                      _passwordController.text.isEmpty ==
                                          false &&
                                      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                          .hasMatch(_emailController.text)) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Text(
                                          'Vui lòng xác nhận mật khẩu',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Text(
                                            'Vui lòng xác nhận mật khẩu để đăng ký.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 6, 103, 223)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } else if (value != _passwordController.text) {
                                  if (_emailController.text.isEmpty == false &&
                                      _passwordController.text.isEmpty ==
                                          false &&
                                      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                          .hasMatch(_emailController.text)) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Text(
                                          'Mật khẩu bạn nhập không khớp',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Text(
                                            'Vui lòng nhập chính xác mật khẩu để đăng ký.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 6, 103, 223)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                                return null;
                              },
                            ),
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
                                bool isSignup = await authService.signUp(
                                    UserSignup(
                                        email: email,
                                        password: password,
                                        uuid: "string"));
                                setState(() {
                                  _loading =
                                      false; // Ẩn màn hình loading khi xong
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
                                  signup();
                                }
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 35.0),
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "Tạo tài khoản",
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
            ),
          )
        ],
      ),
    ));
  }
}
