import 'package:flutter_application/tabs/home_tab.dart';
import 'package:flutter_application/tabs/friend_tab.dart';

import 'package:flutter_application/tabs/profile_tab.dart';
import 'package:flutter_application/tabs/notifications_tab.dart';
import 'package:flutter_application/tabs/menu_tab.dart';
import 'package:flutter/material.dart';

import '../search/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
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
            const Row(
              children: <Widget>[
                Text('facebook',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold)),
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
                      MaterialPageRoute(builder: (context) => const SearchScreen()),
                    );
                  },
                  child: const Icon(Icons.search, color: Colors.black),
                ),
                const SizedBox(width: 15.0),
                const Icon(Icons.message,
                    color: Colors
                        .black), // Thay thế FontAwesomeIcons.facebookMessenger bằng Icon thông thường
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.blueAccent,
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blueAccent,
          tabs: const [
            Tab(icon: Icon(Icons.home, size: 30.0)),
            Tab(icon: Icon(Icons.people, size: 30.0)),
            Tab(icon: Icon(Icons.account_circle, size: 30.0)),
            Tab(icon: Icon(Icons.notifications, size: 30.0)),
            Tab(icon: Icon(Icons.menu, size: 30.0))
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: const [
        HomeTab(),
        FriendsTab(),
        Profile(),
        NotificationsTab(),
        MenuTab()
      ]),
    );
  }
}
