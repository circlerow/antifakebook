import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/firebase_api.dart';
import 'package:flutter_application/firebase_options.dart';

import 'package:flutter_application/presentation/login/login.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

void main() async {
  //await dot_env.dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAPI().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor:
              Colors.grey[200], // Thiết lập màu nền cho toàn bộ ứng dụng
          // Các thiết lập theme khác
        ),
        debugShowCheckedModeBanner: false,
        home: const Login());
    //home: signUpPage());
  }
}
