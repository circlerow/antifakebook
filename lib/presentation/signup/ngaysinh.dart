import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/signup/chinhsach.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class ngaySinh extends StatefulWidget {
  String ho, ten;
  ngaySinh({super.key, required this.ho, required this.ten});
  DateTime birthday = DateTime.now();

  @override
  _ngaySinhPageState createState() => _ngaySinhPageState();
}

class _ngaySinhPageState extends State<ngaySinh> {
  DateTime _selectedDate = DateTime.now();
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ngày sinh'),
      ),
      body: Column(
        children: [
          Container(
            child: Text('Sinh nhật của bạn khi nào?'),
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            child: Text(
              "$_selectedDate",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 250,
            child: ScrollDatePicker(
              selectedDate: _selectedDate,
              locale: Locale('en'),
              onDateTimeChanged: (DateTime value) {
                setState(() {
                  _selectedDate = value;
                  widget.birthday = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChinhSach()));
              print(" Ho: " + widget.ho);
              print(" Ten: " + widget.ten);
              print(" Birthday: " + widget.birthday.toString());
            },
            child: Text('Tiếp'),
          )
        ],
      ),
    );
  }
}

class NgaySinh2 extends StatelessWidget {
  const NgaySinh2({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: ngaySinh(ho: "MAI ", ten: "KHANh"),
    );
  }
}
