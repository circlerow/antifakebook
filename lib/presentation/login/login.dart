import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth_service.dart';
import 'package:flutter_application/data/auth_repository.dart';
import 'package:flutter_application/domain/user_login.dart';
import 'package:flutter_application/presentation/home/home.dart';

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
  bool isUsernameEmpty = false;
  final AuthService authService =
      AuthService(authRepository: AuthRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0, // Điều chỉnh chiều cao của AppBar (tuỳ chọn)
          flexibleSpace: Container(
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
          ),
        ),
        backgroundColor:
            Colors.transparent, // Đặt màu nền của Scaffold thành trong suốt
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
                  // Các phần tử khác trong body của Scaffold
                  child: SingleChildScrollView(
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 80.0,
                                bottom: 120.0,
                              ),
                              child: Image.asset(
                                'assets/icon.webp',
                                width: 72.0,
                                height: 72.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 60,
                              padding: EdgeInsets.only(
                                  left: 15.0,
                                  right:
                                      15.0), // Khoảng cách nằm trong Container
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color:
                                        Colors.grey[400]!), // Màu viền xám nhẹ
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: userNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Text(
                                          'Cần có thông tin tên đăng nhập',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Text(
                                            'Nhập tên đăng nhập của bạn để tiếp tục.'),
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
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Tên đăng nhập',
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 156, 160, 164)),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 60,
                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color:
                                        Colors.grey[400]!), // Màu viền xám nhẹ
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: const EdgeInsets.only(
                                  top: 12.0, bottom: 12.0),
                              child: TextFormField(
                                controller: passWordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    if (isUsernameEmpty == false) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(
                                            'Nhập mật khẩu của bạn để đăng nhập',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: Text(
                                              'Vui lòng nhập mật khẩu để đăng nhập.'),
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
                                    } else {
                                      return null;
                                    }
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Mật khẩu',
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 156, 160, 164)),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: const EdgeInsets.only(bottom: 300.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Kiểm tra và xác thực dữ liệu trước khi đăng nhập
                                  if (_formKey.currentState!.validate()) {
                                    String userName = userNameController.text;
                                    String passWord = passWordController.text;
                                    print("userName: $userName");
                                    print("passWord: $passWord");

                                    bool isLogin = await authService.login(
                                        UserLogin(
                                            email: userName,
                                            password: passWord,
                                            uuid: "string"));

                                    if (isLogin) {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                      255, 6, 103, 223), // Màu nền xanh
                                ),
                                child: const Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen()));
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 255, 255, 255)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(255, 6, 103,
                                              223)), // Màu chữ trắng
                                  side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(
                                        color: Colors.blue
                                            .shade900), // Màu viền xanh dương
                                  ),
                                ),
                                child: const Text('Tạo tài khoản mới'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
