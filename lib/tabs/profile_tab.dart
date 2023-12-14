import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_application/application/friend_service.dart';
import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/data/friend_repository.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/friend.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/presentation/profile/option_profile.dart';
import 'package:flutter_application/widgets/separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileTab createState() => ProfileTab();
}

class ProfileTab extends State<Profile> {
  late User user;
  late List<Friend> friends;
  late String total;
  late Future<void> _dataFuture;
  Uint8List? _avatar;
  File? selectedAvatar;
  Uint8List? _backGr;
  File? selectedBackGr;

  @override
  void initState() {
    _dataFuture = fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id')!;
    UserService userService = UserService(userRepository: UserRepositoryImpl());
    FriendService friendService =
        FriendService(friendRepository: FriendRepositoryImpl());
    User fetchedUser = await userService.getUserInfo(userId);
    dynamic listFriend = await friendService.getUserFriends("0", "6", userId);

    ///dynamic listFriend = await friendService.getUserFriends("0", "6", userId);
    print("user = " + fetchedUser.toString());
    http.Response avatarHttp = await http.get(Uri.parse(fetchedUser
            .avatar.isNotEmpty
        ? fetchedUser.avatar
        : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"));

    http.Response backgrHttp = await http.get(Uri.parse(fetchedUser
            .coverImage.isNotEmpty
        ? fetchedUser.coverImage
        : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"));

    setState(() async {
      friends = listFriend["friends"];
      total = listFriend["total"];
      user = fetchedUser;
      _avatar = avatarHttp.bodyBytes;
      selectedAvatar = File.fromRawPath(_avatar!);
      _backGr = backgrHttp.bodyBytes;
      selectedBackGr = File.fromRawPath(_backGr!);
    });
  }

  Future<void> updateAvatar() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _avatar = File(returnImage.path).readAsBytesSync();
      selectedAvatar = File(returnImage.path);
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  Future<void> updateBackGr() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _backGr = File(returnImage.path).readAsBytesSync();
      selectedBackGr = File(returnImage.path);
      Navigator.of(context, rootNavigator: true).pop();
    });
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

  void _showPopupBackGround(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Ảnh Bìa'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // Hành động khi nhấn vào "Xem ảnh bìa"
                Navigator.of(context).pop();
                // Thêm hành động của bạn ở đây, ví dụ: điều hướng đến trang xem ảnh bìa
              },
              child: Text('Xem ảnh bìa'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                // Hành động khi nhấn vào "Tải ảnh bìa lên"
                await updateBackGr();
                //Navigator.of(context).pop();
                // Thêm hành động của bạn ở đây, ví dụ: mở màn hình để tải ảnh lên

                final returnImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (returnImage == null) return;
                setState(() {});
              },
              child: Text('Tải ảnh bìa lên'),
            ),
          ],
        );
      },
    );
  }

  void _showPopupAvatar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Ảnh đại diện'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // Hành động khi nhấn vào "Xem ảnh bìa"
                Navigator.of(context).pop();
                // Thêm hành động của bạn ở đây, ví dụ: điều hướng đến trang xem ảnh bìa
              },
              child: Text('Xem ảnh đại diện'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                // Hành động khi nhấn vào "Tải ảnh bìa lên"
                //Navigator.of(context).pop();
                await updateAvatar();
                // Thêm hành động của bạn ở đây, ví dụ: mở màn hình để tải ảnh lên
              },
              child: Text('Tải ảnh lên'),
            ),
          ],
        );
      },
    );
  }

  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
          height: 330.0,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  height: 180.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(_backGr!), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(00.0)),
                ),
                onTap: () {
                  _showPopupBackGround(context);
                },
              ),
              Positioned(
                left: 20.0,
                top: 70.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 75.0,
                        child: GestureDetector(
                          child: CircleAvatar(
                            backgroundImage: MemoryImage(_avatar!),
                            radius: 70.0,
                          ),
                          onTap: () {
                            print("press");
                            _showPopupAvatar(context);
                          },
                        )),
                    Text(user.username,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold)),
                    Text(user.description,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width / 8 * 6.5,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 33, 40, 243),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Center(
                            child: Text('Add to Story',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0))),
                      ),
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width / 8 * 1,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Icon(Icons.more_horiz),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Divider(height: 40.0),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.home,
                      color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                  SizedBox(width: 10.0),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'Sống tại '),
                        TextSpan(
                            text: '${user.address}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Icon(Icons.location_on,
                      color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                  SizedBox(width: 10.0),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'Đến từ '),
                        TextSpan(
                            text: '${user.country}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15.0),
              const Row(
                children: <Widget>[
                  Icon(Icons.more_horiz, color: Colors.grey, size: 30.0),
                  SizedBox(width: 10.0),
                  Text('See your About Info', style: TextStyle(fontSize: 16.0))
                ],
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OptionProfile(
                              user: user,
                            )),
                  );
                },
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 33, 37, 243)
                        .withOpacity(0.10),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                      child: Text('Chỉnh sửa chi tiết công khai',
                          style: TextStyle(
                              color: Color.fromARGB(255, 33, 37, 243),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0))),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 40.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Bạn bè',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6.0),
                      Text('$total bạn bè',
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[800])),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: friends.map((friend) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(friend.avatar),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          friend.username,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }).toList(), // Chuyển danh sách thành List
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Center(
                    child: Text('See All Friends',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0))),
              ),
            ],
          ),
        ),
        const SeparatorWidget()
      ],
    ));
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
