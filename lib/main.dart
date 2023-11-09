import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/firebase_api.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/presentation/home/home.dart';

import 'package:flutter_application/presentation/login/login.dart';
import 'package:flutter_application/presentation/signup/signUp.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

void main() async {
  //await dot_env.dotenv.load();
  await WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAPI().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
    //home: signUpPage());
  }
}
