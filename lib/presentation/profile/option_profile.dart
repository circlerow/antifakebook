import 'package:flutter/material.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/presentation/signup/hoTen.dart';
import 'package:flutter_application/widgets/separator_widget.dart';

class OptionProfile extends StatefulWidget {
  late User user;

  OptionProfile({required this.user, Key? key}) : super(key: key);

  @override
  _OptionProfileState createState() => _OptionProfileState();
}

class _OptionProfileState extends State<OptionProfile> {
  TextEditingController _postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        //shadowColor: Colors.transparent,
        title: Text(
          'Chỉnh sửa trang cá nhân',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16, 0),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Ảnh đại diện',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Chỉnh sửa',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                )
              ],
            ),
            GestureDetector(
              child: ClipOval(
                child: CircleAvatar(
                  radius: 72.0,
                  backgroundColor: const Color.fromARGB(
                      255, 255, 255, 255), // Màu nền mặc định
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundColor: Colors.white, // Màu nền cho hình tròn
                    backgroundImage: NetworkImage(
                      widget.user.avatar.isNotEmpty
                          ? widget.user.avatar
                          : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png",
                    ),
                  ),
                ),
              ),
              onTap: () {
                print("press");
                // _showPopupAvatar(context);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            SeparatorWidget(),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Text(
                  'Ảnh bìa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                Spacer(),
                Text(
                  'Chỉnh sửa',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                height: 180.0,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/cover.jpg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              onTap: () {
                //  _showPopupBackGround(context);
              },
            ),
            const SizedBox(height: 16),
            SeparatorWidget(),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Text(
                  'Tiểu sử',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                Spacer(),
                Text(
                  'Chỉnh sửa',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 300,
                child: const Text(
                  "tieu su",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SeparatorWidget(),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Text(
                  'Chi tiết',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                Spacer(),
                Text(
                  'Chỉnh sửa',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.home,
                    color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                SizedBox(width: 10.0),
                Text('Sống tại ' + widget.user.address,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Icon(Icons.location_on,
                    color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                SizedBox(width: 10.0),
                Text('Đến từ' + widget.user.country,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))
              ],
            ),
            const SizedBox(height: 16),
            SeparatorWidget(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Thực hiện xử lý khi người dùng nhấn nút đăng bài
                save();
              },
              child: Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }

  void save() {}
}
