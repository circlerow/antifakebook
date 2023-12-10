import 'package:flutter_application/tabs/home_tab.dart';
import 'package:flutter_application/tabs/friend_tab.dart';

import 'package:flutter_application/tabs/profile_tab.dart';
import 'package:flutter_application/tabs/notifications_tab.dart';
import 'package:flutter_application/tabs/menu_tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
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
    _tabController = TabController(vsync: this, length: 6);
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
            const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.search, color: Colors.black),
                  SizedBox(width: 15.0),
                  Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black)
                ]),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.blueAccent,
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
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
        Profile(),
        NotificationsTab(),
        MenuTab()
      ]),
    );
  }
}
