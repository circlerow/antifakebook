import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/firebase_api.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/presentation/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAPI().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor:
              Color.fromARGB(255, 255, 255, 255), // Thiết lập màu nền cho toàn bộ ứng dụng
          // Các thiết lập theme khác
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}