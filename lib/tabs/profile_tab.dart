import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_application/application/friend_service.dart';
import 'package:flutter_application/application/post_service.dart';
import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/controller/profileController.dart';
import 'package:flutter_application/data/friend_repository.dart';
import 'package:flutter_application/data/post_repository.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/friend.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/presentation/friend/FriendList.dart';
import 'package:flutter_application/presentation/profile/option_profile.dart';
import 'package:flutter_application/widgets/post_widget.dart';
import 'package:flutter_application/widgets/separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  late UserController userCtrl;
  Profile({super.key, required this.userCtrl});

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
  late List<Post> posts;

  @override
  void initState() {
    print(" RUN");
    print(" RUN");
    print(" RUN");
    _dataFuture = fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    PostService postService = PostService(postRepository: PostRepositoryImpl());
    UserService userService = UserService(userRepository: UserRepositoryImpl());

    FriendService friendService =
        FriendService(friendRepository: FriendRepositoryImpl());

    List<Future> furures = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id')!;
    User fetchedUser = await UserController.getUser();
    furures.add(postService.getListPost({
      "user_id": userId,
      "in_campaign": "1",
      "campaign_id": "1",
      "latitude": "1.0",
      "longitude": "1.0",
      "last_id": "",
      "index": "0",
      "count": "20"
    }));

    furures.add(friendService.getUserFriends("0", "6", userId));
    List<dynamic> result = await Future.wait(furures);
    List<Post> fetchedPosts = result[0];
    dynamic listFriend = result[1];
    print(" Total " + fetchedPosts.length.toString() + " Posts");
    setState(() async {
      friends = listFriend["friends"];
      total = listFriend["total"];
      user = fetchedUser;

      selectedAvatar = File(UserController.fileAvatar);

      selectedBackGr = File(UserController.fileBackGr);

      _avatar = selectedAvatar!.readAsBytesSync();
      _backGr = selectedBackGr!.readAsBytesSync();
      posts = fetchedPosts;
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
          height: 350.0,
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
                            _showPopupAvatar(context);
                          },
                        )),
                    SizedBox(height: 20.0),
                    Text(user.username,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold)),
                    Text(user.description,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Positioned(
                  left: 52.0,
                  top: 190.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width / 8 * 2,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 242, 252),
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Căn giữa các thành phần trong hàng ngang
                            children: [
                              Image.asset(
                                'assets/coin.png',
                                width: 20.0,
                                height: 20.0,
                              ),
                              SizedBox(
                                  width: 5.0), // Khoảng cách giữa icon và text
                              Text(
                                '${user.coins} coin',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 1, 101, 255),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
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
                            color: const Color.fromARGB(255, 1, 101, 255),
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
                        TextSpan(
                            text: 'Sống tại ', style: TextStyle(fontSize: 18)),
                        TextSpan(
                            text: '${user.address}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
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
                        TextSpan(
                            text: 'Đến từ ', style: TextStyle(fontSize: 18)),
                        TextSpan(
                            text: '${user.country}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
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
                  Text('Xem thông tin giới thiệu của bạn',
                      style: TextStyle(fontSize: 18.0))
                ],
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OptionProfile(
                              user: user,
                            )),
                  );
                  //  print("Result = " + result);
                  // if (result != null && result == true) {
                  setState(() {
                    user = UserController.user;
                    selectedAvatar = File(UserController.fileAvatar);
                    _avatar = File(UserController.fileAvatar).readAsBytesSync();
                    selectedBackGr = File(UserController.fileBackGr);
                    _backGr = File(UserController.fileBackGr).readAsBytesSync();
                  });
                  //  }
                },
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 1, 101, 255).withOpacity(1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                      child: Text('Chỉnh sửa chi tiết công khai',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0))),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 20.0),
        FriendList(friends: friends, total: total),
        const SeparatorWidget(),
        for (Post post in posts)
          Column(
            children: <Widget>[
              const SeparatorWidget(),
              PostWidget(post: post),
            ],
          ),
        const SeparatorWidget(),
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
