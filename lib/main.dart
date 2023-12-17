import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/firebase_api.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/presentation/home/home.dart';
import 'package:flutter_application/presentation/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAPI().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  Widget initWidget =
      token != null && token.isNotEmpty ? HomePage() : const Login();
  runApp(MyApp(
    initialWidget: initWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? initialWidget;

  const MyApp({Key? key, required this.initialWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: initialWidget ?? Container(),
    );
  }
}
