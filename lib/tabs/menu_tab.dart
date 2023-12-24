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
import 'package:flutter_application/widgets/menu/shortcut.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../presentation/setting/deposit_coin.dart';
import '../presentation/setting/list_block.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Shortcut(
                                  img: 'assets/images/menu/friends.png',
                                  title: 'Bạn bè'),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoPage()),
                            );
                          },
                          child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 0),
                                      spreadRadius: 0,
                                    ),
                                  ]),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoPage()),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: const Shortcut(
                                      img: 'assets/images/menu/video.png',
                                      title: 'Video'),
                                ),
                              ))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const MyWidget(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Điều chỉnh độ cong tại đây
                        side: const BorderSide(
                          color: Colors.black12,
                          width: 0,
                        ),
                      ),
                      backgroundColor: Colors.grey[300],
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () async {
                      await authService.logout();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      'Đăng xuất',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
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
                   
                    Image.asset('assets/img/icon/settings.png',
                        width: 20.0, height: 20.0),
                    const SizedBox(width: 10.0),

                    const Text('Cài đặt & quyền riêng tư',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        )),

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
                        _listBlock('Danh sách chặn'),
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

  Widget _listBlock(String optionText) {
    return SizedBox(
      height: 40.0,
      child: ListTile(
        leading: const Icon(Icons.block,
            size: 40.0, color: Color.fromARGB(255, 21, 237, 132)),
        title: Text(optionText),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListBlockScreen()),
          );
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