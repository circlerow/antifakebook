import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/home.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

void main() async {
  //await dot_env.dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
