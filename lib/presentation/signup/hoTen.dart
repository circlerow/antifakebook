import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/signup/ngaysinh.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class hoTen extends StatelessWidget {
  hoTen({super.key});
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController userNameController = TextEditingController();
  // TextEditingController passWordController = TextEditingController();
  String? ho, ten;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 255, 1),
        title: Text('Tên'),
      ),
      body: Center(
        child: Form(
          // key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 20.0,
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  //    controller: userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Họ không được để trống';
                    }
                    return null;
                  },
                  onChanged: (value) => {ho = value},
                  decoration: InputDecoration(
                    labelText: 'Họ',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                child: TextFormField(
                  // controller: passWordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên không được để trống';
                    }
                    return null;
                  },
                  onChanged: (value) => {ten = value},
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Tên',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ngaySinh(ho: this.ho!, ten: this.ten!)));
                },
                child: Text('Tiếp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
