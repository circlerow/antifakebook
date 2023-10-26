import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/signup/hoTen.dart';

class signUpPage extends StatelessWidget {
  signUpPage({super.key});

  var ho, ten, ngaySinh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tạo Tài Khoản'),
        ),
        body: Center(
            child: Column(children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Image.asset('assets/icon.webp'),
          ),
          Container(
              child: Text(
            'Tham gia Facebook',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          Container(
            child: Text(
                'Chúng tôi sẽ giúp bạn tạo tài khoản mới sau vài bước dễ dàng'),
          ),
          ElevatedButton(
            onPressed: () {
              // change page two
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => hoTen()));
            },
            child: Text('Tiếp'),
          )
        ])));
  }
}
