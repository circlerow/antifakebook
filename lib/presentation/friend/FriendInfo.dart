// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application/application/friend_service.dart';
import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/data/friend_repository.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/friend.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/presentation/friend/FriendList.dart';
import 'package:flutter_application/presentation/home/home.dart';
import 'package:flutter_application/tabs/home_tab.dart';
import 'package:flutter_application/tabs/profile_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home.dart';

class FriendInfo extends StatefulWidget {
  final String friendId;
  const FriendInfo({super.key, required this.friendId});

  @override
  _FriendInfoState createState() => _FriendInfoState();
}

class _FriendInfoState extends State<FriendInfo> {
  final FriendService _friendService =
      FriendService(friendRepository: FriendRepositoryImpl());
  final UserService _userService =
      UserService(userRepository: UserRepositoryImpl());

  late String isFriends;
  late User friend;
  late Future<void> _dataFuture;
  late List<Friend> friends;
  late String total;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString('user_id')!;
    if(widget.friendId == userId){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
    }
    Map<String, dynamic> fetchedPosts =
        await _friendService.getUserFriends("0", "6", widget.friendId);

    friend = await _userService.getUserInfo(widget.friendId);

    setState(() {
      friends = fetchedPosts['friends'];
      total = fetchedPosts['total'];
      isFriends = friend.isFriend;
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

  Widget buildContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(friend.username),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            color: Colors.white,
            height: 360,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  height: 180.0,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/cover.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(friend.avatar.isNotEmpty
                          ? friend.avatar
                          : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"),
                      radius: 70.0,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                        friend.username.isNotEmpty
                            ? friend.username
                            : "(No Name)",
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            height: 40.0,
                            width:
                                ((MediaQuery.of(context).size.width - 80) / 2),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: GestureDetector(
                                  onTap: () async {
                                    _handleIsFriend(isFriends);
                                  },
                                  child: Text(_convertIsFriend(isFriends),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0))),
                            )),
                        Container(
                            height: 40.0,
                            width:
                                ((MediaQuery.of(context).size.width - 80) / 2),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: GestureDetector(
                                  onTap: () async {},
                                  child: const Text("Nhắn tin",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0))),
                            )),
                        GestureDetector(
                          onTap: () {
                            _showPopup(context);
                          },
                          child: Container(
                            height: 40.0,
                            width: 45.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Icon(Icons.more_horiz),
                          ),
                        )
                      ],
                    ),
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
                    const Icon(Icons.home,
                        color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                    const SizedBox(width: 10.0),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'Sống tại '),
                          TextSpan(
                              text: friend.address,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
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
                      const Icon(Icons.home,
                          color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                      const SizedBox(width: 10.0),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            const TextSpan(text: 'Sống tại '),
                            TextSpan(
                                text: friend.address,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.location_on,
                          color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                      const SizedBox(width: 10.0),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            const TextSpan(text: 'Đến từ '),
                            TextSpan(
                                text: friend.city,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
          const Divider(height: 40.0),
          FriendList(friends: friends, total: total)
        ])));
  }

  String _convertIsFriend(String isFriend) {
    switch (isFriend) {
      case "0":
        return "Thêm bạn bè";
      case "1":
        return "Bạn bè";
      case "2":
        return "Huỷ lời mời";
      case "3":
        return "Phản hồi";
    }
    return "";
  }

  void _handleIsFriend(String isFriend) async {
    switch (isFriend) {
      case "0":
        await _friendService.setRequestFriend(friend.id);
        setState(() {
          isFriends = '2';
        });
        break;
      case "2":
        await _friendService.delRequestFriend(friend.id);
        setState(() {
          isFriends = '0';
        });
        break;
      case "3":
        await _friendService.setAcceptFriend(friend.id, "1");
        setState(() {
          isFriends = '1';
        });
        break;
    }
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

  void _showPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await _friendService.blockFriend(friend.id);
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.block),
                    SizedBox(width: 8.0),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Chặn người dùng',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}