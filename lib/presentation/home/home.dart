// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter_application/controller/notificationController.dart';
import 'package:flutter_application/controller/profileController.dart';
import 'package:flutter_application/tabs/home_tab.dart';
import 'package:flutter_application/tabs/friend_tab.dart';

import 'package:flutter_application/tabs/profile_tab.dart';
import 'package:flutter_application/tabs/notifications_tab.dart';
import 'package:flutter_application/tabs/menu_tab.dart';
import 'package:flutter/material.dart';

import '../search/search.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  late NotificationController notificationController;
  late UserController userController;
  @override
  _HomePageState createState() => _HomePageState();
  Image img = Image.asset('asset/img/nav/topHome.png');
}
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    widget.notificationController = new NotificationController();
    widget.userController = new UserController();
    widget.userController.init();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //brightness: Brightness.light,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset('assets/img/nav/topHome.png',
                    width: 120.0, height: 120.0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Chuyển đến trang tìm kiếm khi ấn vào biểu tượng tìm kiếm
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()),
                    );
                  },
                  child: const Icon(Icons.search, color: Colors.black),
                ),
                const SizedBox(width: 15.0),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.blueAccent,
          controller: _tabController,
          unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
          labelColor: Colors.blueAccent,
          tabs: [
            Tab(
                child: Image.asset('assets/img/nav/home.png',
                    width: 20.0, height: 20.0)),
            Tab(
                child: Image.asset('assets/img/nav/friends.png',
                    width: 20.0, height: 20.0)),
            Tab(
                child: Image.asset('assets/img/nav/profile.png',
                    width: 20.0, height: 20.0)),
            Tab(
                child: Image.asset('assets/img/nav/noti.png',
                    width: 20.0, height: 20.0)),
            Tab(
                child: Image.asset('assets/img/nav/menu.png',
                    width: 20.0, height: 20.0))
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        HomeTab(),
        FriendsTab(),
        Profile(
          userCtrl: widget.userController,
        ),
        NotificationsTab(
          ctrl: widget.notificationController,
        ),
        MenuTab()
      ]),
    );
  }
}
