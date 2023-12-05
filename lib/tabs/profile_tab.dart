import 'package:flutter_application/application/friend_service.dart';
import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/data/friend_repository.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/friend.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/widgets/separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget{
  @override
  ProfileTab createState() => ProfileTab();
}


class ProfileTab extends State<Profile> {

  late User user;
  late List<Friend> friends;
  late String total;
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id')!;
    UserService userService = UserService(userRepository: UserRepositoryImpl());
    FriendService friendService = FriendService(friendRepository: FriendRepositoryImpl());
    User fetchedUser = await userService.getUserInfo(userId);
    dynamic listFriend = await friendService.getUserFriends("0","6",userId);
    setState(() {
      user = fetchedUser;
      friends = listFriend["friends"];
      total = listFriend["total"];
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
        child: Column(
        children: <Widget>[
        Container(
          height: 360.0,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                height: 180.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/cover.jpg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar.isNotEmpty ? user.avatar : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"),
                    radius: 70.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(user.username,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                            child: Text('Add to Story',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0))),
                      ),
                      Container(
                        height: 40.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Icon(Icons.more_horiz),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Divider(height: 40.0),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.home, color: Colors.grey, size: 30.0),
                  SizedBox(width: 10.0),
                  Text('Lives in ' + user.address, style: TextStyle(fontSize: 16.0))
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Icon(Icons.location_on, color: Colors.grey, size: 30.0),
                  SizedBox(width: 10.0),
                  Text('From ' + user.country, style: TextStyle(fontSize: 16.0))
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Icon(Icons.more_horiz, color: Colors.grey, size: 30.0),
                  SizedBox(width: 10.0),
                  Text('See your About Info', style: TextStyle(fontSize: 16.0))
                ],
              ),
              SizedBox(height: 15.0),
              Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                    child: Text('Edit Public Details',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0))),
              ),
            ],
          ),
        ),
        Divider(height: 40.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Bạn bè',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6.0),
                      Text(total+' bạn bè',
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
                        SizedBox(height: 5.0),
                        Text(
                          friend.username,
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }).toList(), // Chuyển danh sách thành List
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                    child: Text('See All Friends',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0))),
              ),
            ],
          ),
        ),
        SeparatorWidget()
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
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
