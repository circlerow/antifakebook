// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application/data/auth_repository.dart';
import 'package:flutter_application/domain/user_login.dart';
import 'package:flutter_application/presentation/home/home.dart';
import 'package:flutter_application/application/auth_service.dart';

import '../signup/create_account.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LoginPage(title: 'Login'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  final AuthService authService =
      AuthService(authRepository: AuthRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 255, 1),
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 48.0,
                  bottom: 48.0,
                ),
                child: Image.asset(
                  'assets/icon.webp',
                  width: 72.0,
                  height: 72.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên đăng nhập không được để trống';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tên đăng nhập',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                child: TextFormField(
                  controller: passWordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mật khẩu không được để trống';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Kiểm tra và xác thực dữ liệu trước khi đăng nhập
                  if (_formKey.currentState!.validate()) {
                    String userName = userNameController.text;
                    String passWord = passWordController.text;
                    print("userName: $userName");
                    print("passWord: $passWord");

                    bool isLogin = await authService.login(UserLogin(
                        email: userName, password: passWord, uuid: "string"));

                    if (isLogin) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    }
                  }
                },
                child: const Text('Đăng nhập'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()));
                },
                child: const Text('Đăng ký'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
