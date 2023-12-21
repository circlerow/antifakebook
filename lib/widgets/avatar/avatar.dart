import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/controller/profileController.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  late Future<String> _avatar;

  @override
  void initState() {
    _avatar = UserController.getAvatar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _avatar,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/avatar.jpg'),
          ); // Hiển thị loading khi đang chờ dữ liệu
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Xử lý khi có lỗi xảy ra
        } else {
          String linkAvatar =
              snapshot.data ?? ''; // Lấy link avatar từ dữ liệu đã tải
          return _buildWidgetWithAvatarLink(context, linkAvatar);
        }
      },
    );
  }

  Widget _buildWidgetWithAvatarLink(BuildContext context, String linkAvatar) {
    return CircleAvatar(
      radius: 25.0,
      backgroundImage: FileImage(File(linkAvatar)),
    );
  }
}
