import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/firebase_api.dart';
import 'package:flutter_application/presentation/home/home.dart';
import 'package:flutter_application/presentation/signup/signUp.dart';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LoginPage(title: 'Login'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title});

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

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
                margin: EdgeInsets.only(
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
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên đăng nhập không được để trống';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
                    var token = await FirebaseMessaging.instance.getToken();
                    //
                    Map<String, dynamic> data = {
                      "username": userName,
                      "password": passWord,
                      "token": token.toString(),
                    };

                    print("body " + json.encode(data));

                    var headers = {
                      'Content-Type': 'application/json',
                      'Authorization': '',
                    };
                    try {
                      var response = await http.post(
                          Uri.parse('http://10.0.2.2:3333/login'),
                          headers: headers,
                          body: json.encode(data));
                      print(response.statusCode);
                    } catch (e) {
                      print(e);
                    }

                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
                child: Text('Đăng nhập'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signUpPage()));
                },
                child: Text('Đăng ký'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
