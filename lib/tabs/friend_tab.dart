import 'package:flutter/material.dart';
import 'package:flutter_application/application/friend_service.dart';
import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/data/friend_repository.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/friend.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/presentation/friend/FriendInfo.dart';

class FriendsTab extends StatefulWidget{
  @override
  FriendsTabPage createState() => FriendsTabPage();
}

class FriendsTabPage extends State<FriendsTab> {

  FriendService friendService = FriendService(friendRepository: FriendRepositoryImpl());
  UserService userService = UserService(userRepository: UserRepositoryImpl());
  late Future<void> _dataFuture;
  late List<Friend> friends = [];
  late List<Friend> friendSuggesteds = [];
  late String total;
  List<bool> isFriendRequestSent = List.filled(1000, false);
  List<bool> isFriendList = List.filled(1000, false);

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<void> fetchData() async {
    Map<String, dynamic> fetchedPosts = await friendService.getRequestedFriends({
      "index": "0",
      "count": "5"
    });

    List<Friend> fetchFriendSuggested = await friendService.getSuggestedFriends({
      "index": "0",
      "count": "10"
    });

    setState(() {
      friends = fetchedPosts['friends'];
      total = fetchedPosts['total'];
      friendSuggesteds = fetchFriendSuggested;
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
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Bạn bè',
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Gợi ý',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Tất cả bạn bè',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              Divider(height: 30.0),
              Row(
                children: <Widget>[
                  Text('Lời mời kết bạn',
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10.0),
                  Text(total,
                      style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                children: friends.map((friend) {
                  return Column(
                    children: [
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              User res = await userService.getUserInfo(friend.id);
                              print(res.isFriend);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FriendInfo(friend: res,)),
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(friend.avatar.isNotEmpty ? friend.avatar : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"),
                              radius: 40.0,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                friend.username,
                                style:
                                    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: <Widget>[
                                  if (!isFriendList[int.tryParse(friend.id)!])
                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () async {
                                            bool sendRequest = await friendService.setAcceptFriend(friend.id,"1");
                                            if(sendRequest){
                                              setState(() {
                                                isFriendList[int.tryParse(friend.id)!] = true;
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text(
                                              'Xác nhận',
                                              style: TextStyle(color: Colors.white, fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.0),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: Text(
                                            'Xoá',
                                            style: TextStyle(color: Colors.black, fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Text(
                                      'Lời mời được chấp nhận',
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                    ],
                  );
                }).toList(),
              ),
              Divider(height: 30.0),
              Text('Những người bạn có thể biết',
                  style:
                      TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Column(
                children: friendSuggesteds.map((friend) {
                  return Column(
                    children: [
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              print(friend.id);
                              User res = await userService.getUserInfo(friend.id);
                              print(res.isFriend);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FriendInfo(friend: res,)),
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(friend.avatar.isNotEmpty ? friend.avatar : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"),
                              radius: 40.0,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                friend.username.isNotEmpty ? friend.username : "(No Name)",
                                style:
                                    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: <Widget>[
                                  if (!isFriendRequestSent[int.tryParse(friend.id)!])
                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () async {
                                            bool sendRequest = await friendService.setRequestFriend(friend.id);
                                            if(sendRequest){
                                              setState(() {
                                                isFriendRequestSent[int.tryParse(friend.id)!] = true;
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text(
                                              'Thêm bạn bè',
                                              style: TextStyle(color: Colors.white, fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.0),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: Text(
                                            'Gỡ',
                                            style: TextStyle(color: Colors.black, fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Text(
                                      'Đã gửi lời mời kết bạn',
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                    ],
                  );
                }).toList(),
              ),
            ],
          )),
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
}
