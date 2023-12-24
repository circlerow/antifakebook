import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/controller/profileController.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/widgets/separator_widget.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionProfile extends StatefulWidget {
  late User user;

  OptionProfile({required this.user, Key? key}) : super(key: key);

  @override
  _OptionProfileState createState() => _OptionProfileState();
}

class _OptionProfileState extends State<OptionProfile> {
  late Uint8List? _avatar;
  late Uint8List? _backGr;
  File? selectedAvatar;
  File? selectedBackGr;
  late User newUser;
  late Future<void> _dataFuture;
  TextEditingController _tieusuEdit = TextEditingController();
  TextEditingController _addressEdit = TextEditingController();
  TextEditingController _countryEdit = TextEditingController();

  String getExtensionFromUrl(String url) {
    int index = url.lastIndexOf('.');
    return index != -1 ? url.substring(index + 1) : '';
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id')!;
    UserService userService = UserService(userRepository: UserRepositoryImpl());
    User fetchedUser = await userService.getUserInfo(userId);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String extensionAvatar = getExtensionFromUrl(widget.user.avatar);
    String fileAvatar = '$tempPath/avatar_image.$extensionAvatar';
    String extensionBackGr = getExtensionFromUrl(widget.user.avatar);
    String fileBackGr = '$tempPath/cover_image.$extensionBackGr';

    newUser = fetchedUser;

    http.Response avatarHttp = await http.get(Uri.parse(newUser
            .avatar.isNotEmpty
        ? newUser.avatar
        : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"));

    await File(fileAvatar).writeAsBytes(avatarHttp.bodyBytes);
    selectedAvatar = File(fileAvatar);

    http.Response backgrHttp = await http.get(Uri.parse(newUser
            .coverImage.isNotEmpty
        ? newUser.coverImage
        : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"));

    await File(fileBackGr).writeAsBytes(backgrHttp.bodyBytes);
    selectedBackGr = File(fileBackGr);

    setState(() async {
      _avatar = avatarHttp.bodyBytes;

      _backGr = backgrHttp.bodyBytes;
    });
  }

  Future<void> updateAvatar() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _avatar = File(returnImage.path).readAsBytesSync();
      selectedAvatar = File(returnImage.path);

      //Navigator.of(context, rootNavigator: true).pop();
    });
  }

  Future<void> updateBackGr() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _backGr = File(returnImage.path).readAsBytesSync();
      selectedBackGr = File(returnImage.path);
      //Navigator.of(context, rootNavigator: true).pop();
    });
  }

  @override
  void initState() {
    _dataFuture = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Dữ liệu đã tải xong, hiển thị giao diện
          return buildContent(context);
        } else if (snapshot.hasError) {
          // Xử lý lỗi nếu có
          return buildErrorWidget(snapshot.error.toString());
        } else {
          // Hiển thị màn hình loading trong quá trình tải dữ liệu
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget buildContent(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        //shadowColor: Colors.transparent,
        title: const Text(
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
                const Text(
                  'Ảnh đại diện',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    await updateAvatar();
                  },
                  child: const Text(
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
                    backgroundImage: MemoryImage(_avatar!),
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
            Row(
              children: [
                const Text(
                  'Ảnh bìa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    await updateBackGr();
                  },
                  child: const Text(
                    'Chỉnh sửa',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
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
                    image: DecorationImage(
                        image: MemoryImage(_backGr!), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              onTap: () async {
                await updateBackGr();
              },
            ),
            const SizedBox(height: 16),
            SeparatorWidget(),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  'Tiểu sử',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                Spacer(),
                GestureDetector(
                  child: Text(
                    'Chỉnh sửa',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  onTap: () async {
                    _showPopupTieuSu(context);
                  },
                ),
              ],
            ),
            Center(
              child: Container(
                width: 300,
                child: Text(
                  '${newUser.description}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SeparatorWidget(),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  'Chi tiết',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () async {
                      _showPopupChiTiet(context);
                    },
                    child: Text(
                      'Chỉnh sửa',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.home,
                    color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                SizedBox(width: 10.0),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Đến từ '),
                      TextSpan(
                          text: '${newUser.address}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                // Text('Sống tại ' + newUser.address,
                //     style:
                //         TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Icon(Icons.location_on,
                    color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                SizedBox(width: 10.0),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Sống tại '),
                      TextSpan(
                          text: '${newUser.country}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            SeparatorWidget(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await save();
                Navigator.pop(context);
              },
              child: Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildErrorWidget(String error) {
    // Giao diện khi có lỗi
    return Scaffold(
      body: Center(
        child: Text("Error: $error"),
      ),
    );
  }

  Widget buildLoadingWidget() {
    // Giao diện loading
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _showPopupChiTiet(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Chỉnh sửa Chi tiết'),
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.home,
                    color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                SizedBox(width: 10.0),
                Text('Thành phố hiện tại ',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))
              ],
            ),
            Container(
              child: TextFormField(
                controller: _addressEdit,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '${widget.user.address}',
                  contentPadding: EdgeInsets.only(top: 0, left: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Icon(Icons.home,
                    color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                SizedBox(width: 10.0),
                Text('Quê quán ',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))
              ],
            ),
            Container(
              child: TextFormField(
                controller: _countryEdit,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '${widget.user.country}',
                  contentPadding: EdgeInsets.only(top: 0, left: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                setState(() {
                  newUser.address = _addressEdit.text;
                  newUser.country = _countryEdit.text;
                });
                Navigator.pop(context);
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _showPopupTieuSu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Chỉnh sửa tiểu sử'),
          children: <Widget>[
            Container(
              child: TextFormField(
                controller: _tieusuEdit,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'What\'s on your mind?',
                  contentPadding: EdgeInsets.only(top: 0, left: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                setState(() {
                  newUser.description = _tieusuEdit.text;
                });
                Navigator.pop(context, true);
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  save() async {
    print("Save");
    print("newUser" + newUser.username);
    print("newUser" + newUser.description);
    print("newUser" + selectedAvatar!.path);
    print("newUser" + newUser.address);
    print("newUser" + newUser.city);
    print("newUser" + newUser.country);
    print("newUser" + selectedBackGr!.path);

    await UserController.setAvatar(selectedAvatar!);

    await UserController.setBackGr(selectedBackGr!);

    UserController.updatedInfo(newUser);

    UserService userService = UserService(userRepository: UserRepositoryImpl());
    await userService.setUserInfo(
        newUser.username,
        newUser.description,
        selectedAvatar!,
        newUser.address,
        "Hai Phong",
        newUser.country,
        selectedBackGr!,
        "khanh");
  }
}
