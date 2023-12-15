import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/home/home.dart';
import 'package:flutter_application/presentation/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _change = false;

  @override
  void initState() {
    super.initState();
    _navigate();
    _startAnimation();
  }

  Future<void> _navigate() async {
    await Future.delayed(Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _startAnimation() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        _change = !_change;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TweenAnimationBuilder(
                tween: ColorTween(begin: Colors.red, end: Colors.blue),
                duration: Duration(seconds: 2),
                builder: (BuildContext context, dynamic color, Widget? child) {
                  return Icon(
                    FontAwesomeIcons.facebook,
                    color: color,
                    size: MediaQuery.of(context).size.width / 3,
                  );
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'AntiFakebook',
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
