import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/presentation/profile/option_profile.dart';
import 'package:flutter_application/widgets/separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  ProfileTab createState() => ProfileTab();
}

class ProfileTab extends State<Profile> {
  late User user;
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
    User fetchedUser = await userService.getUserInfo(userId);
    setState(() {
      user = fetchedUser;
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

  void _showPopupBackGround(BuildContext context) {
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
              onPressed: () {
                // Hành động khi nhấn vào "Tải ảnh bìa lên"
                Navigator.of(context).pop();
                // Thêm hành động của bạn ở đây, ví dụ: mở màn hình để tải ảnh lên
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
              onPressed: () {
                // Hành động khi nhấn vào "Tải ảnh bìa lên"
                Navigator.of(context).pop();
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
                      image: const DecorationImage(
                          image: AssetImage('assets/cover.jpg'),
                          fit: BoxFit.cover),
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
                            backgroundImage: NetworkImage(user.avatar.isNotEmpty
                                ? user.avatar
                                : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"),
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
                    Text("tieu su",
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
                        child: Icon(Icons.more_horiz),
                      )
                    ],
                  )
                ],
              ),
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
                  Icon(Icons.home,
                      color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                  SizedBox(width: 10.0),
                  Text('Sống tại ' + user.address,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400))
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Icon(Icons.location_on,
                      color: Color.fromARGB(255, 55, 55, 55), size: 30.0),
                  SizedBox(width: 10.0),
                  Text('Đến từ' + user.country,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400))
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
                      Text('Friends',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6.0),
                      Text('536 friends',
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[800])),
                    ],
                  ),
                  Text('See all',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: const Color.fromARGB(255, 33, 37, 243))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/samantha.jpg')),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Samantha',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/andrew.jpg')),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Andrew',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/Sam Wilson.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Sam Wilson',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/steven.jpg')),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Steven',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/greg.jpg')),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Greg',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 3 - 20,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/andy.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        SizedBox(height: 5.0),
                        Text('Andy',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
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
