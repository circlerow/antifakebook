// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/application/auth_service.dart';
import 'package:flutter_application/controller/profileController.dart';
import 'package:flutter_application/data/auth_repository.dart';
import 'package:flutter_application/presentation/login/login.dart';
import 'package:flutter_application/presentation/setting/change_password.dart';
import 'package:flutter_application/presentation/video_pages/videoPage.dart';
import 'package:flutter_application/widgets/avatar/avatar.dart';
import 'package:flutter_application/widgets/avatar/username.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../presentation/setting/deposit_coin.dart';
import '../presentation/setting/setting_notification.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService =
        AuthService(authRepository: AuthRepositoryImpl());

    return SingleChildScrollView(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
            child: Text('Menu',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
          ),
          const Row(
            children: <Widget>[
              SizedBox(width: 15.0),
              AvatarWidget(),
              SizedBox(width: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UsernameWidget(),
                  SizedBox(height: 5.0),
                  Text(
                    'Xem trang cá nhân của bạn',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  )
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(height: 20.0),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: 85.0,
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.group, color: Colors.blue, size: 30.0),
                      SizedBox(height: 5.0),
                      Text('Groups',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 85.0,
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.shopping_basket,
                          color: Colors.blue, size: 30.0),
                      SizedBox(height: 5.0),
                      Text('Marketplace',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: 85.0,
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.person, color: Colors.blue, size: 30.0),
                      SizedBox(height: 5.0),
                      Text('Friends',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoPage()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    height: 85.0,
                    padding: const EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Đổi màu nền thành màu trắng
                      border: Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset('assets/img/icon/video.png',
                            width: 30.0, height: 30.0),
                        SizedBox(height: 5.0),
                        Text('Video',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: 85.0,
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.flag, color: Colors.blue, size: 30.0),
                      SizedBox(height: 5.0),
                      Text('Pages',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 85.0,
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.save_alt, color: Colors.blue, size: 30.0),
                      SizedBox(height: 5.0),
                      Text('Saved',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: 85.0,
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.shoppingBag,
                          color: Colors.blue, size: 25.0),
                      SizedBox(height: 5.0),
                      Text('Jobs',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 85.0,
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.event, color: Colors.blue, size: 30.0),
                      SizedBox(height: 5.0),
                      Text('Events',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          const MyWidget(),
          const Divider(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65.0,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await authService.logout();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(Icons.exit_to_app,
                          size: 40.0, color: Colors.grey[700]),
                      const SizedBox(width: 10.0),
                      const Text('Logout', style: TextStyle(fontSize: 17.0)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isExpanded = false;
  final Color _backgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        color: _backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.settings, size: 40.0, color: Colors.grey[700]),
                    const SizedBox(width: 10.0),
                    const Text('Settings & Privacy',
                        style: TextStyle(fontSize: 17.0)),
                  ],
                ),
                Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 30.0,
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isExpanded ? 215.0 : 0.0,
              child: _isExpanded
                  ? ListView(
                      shrinkWrap: true,
                      children: [
                        _depositCoin('Nạp Coin'),
                        const Divider(),
                        _settingNotification('Cài đặt thông báo'),
                        const Divider(),
                        _buildOptionButton('Thiết lập mã thiết bị'),
                        const Divider(),
                        _changePassword('Đổi mật khẩu'),
                      ],
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String optionText) {
    return SizedBox(
      height: 40.0,
      child: ListTile(
        title: Text(optionText),
        onTap: () {
          print('$optionText tapped!');
        },
      ),
    );
  }

  Widget _depositCoin(String optionText) {
    return SizedBox(
      height: 40.0,
      child: ListTile(
        leading: const Icon(Icons.attach_money,
            size: 40.0, color: Color.fromARGB(255, 211, 211, 11)),
        title: Text(optionText),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DepositScreen()),
          );
        },
      ),
    );
  }

  Widget _changePassword(String optionText) {
    return SizedBox(
      height: 40.0,
      child: ListTile(
        leading: const Icon(Icons.lock_outline,
            size: 40.0, color: Color.fromARGB(255, 255, 0, 162)),
        title: Text(optionText),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
          );
        },
      ),
    );
  }

  Widget _settingNotification(String optionText) {
    return SizedBox(
      height: 40.0,
      child: ListTile(
        leading: const Icon(Icons.circle_notifications_outlined,
            size: 40.0, color: Color.fromARGB(255, 21, 15, 195)),
        title: Text(optionText),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        },
      ),
    );
  }
}
