// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../application/setting_service.dart';
import '../../data/setting_repository.dart';
import '../../domain/setting.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingService settingService =
      SettingService(settingRepository: SettingRepositoryImpl());
  late Future<void> _dataFuture;

  String likeComment = '0';
  String fromFriends = '0';
  String requestedFriend = '0';
  String suggestedFriend = '0';
  String birthday = '0';
  String video = '0';
  String report = '0';
  String soundOn = '0';
  String notificationOn = '0';
  String vibrantOn = '0';
  String ledOn = '0';

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<void> fetchData() async {
    Map<String, dynamic> fetchedSetting = await settingService.getPushSetting();

    setState(() {
      likeComment = fetchedSetting['like_comment'];
      fromFriends = fetchedSetting['from_friends'];
      requestedFriend = fetchedSetting['requested_friend'];
      suggestedFriend = fetchedSetting['suggested_friend'];
      birthday = fetchedSetting['birthday'];
      video = fetchedSetting['video'];
      report = fetchedSetting['report'];
      soundOn = fetchedSetting['sound_on'];
      notificationOn = fetchedSetting['notification_on'];
      vibrantOn = fetchedSetting['vibrant_on'];
      ledOn = fetchedSetting['led_on'];
    });
  }

  Future<void> setPushSetting() async {
    PushSetting pushSetting = PushSetting(
      likeComment: likeComment,
      fromFriends: fromFriends,
      requestedFriend: requestedFriend,
      suggestedFriend: suggestedFriend,
      birthday: birthday,
      video: video,
      report: report,
      soundOn: soundOn,
      notificationOn: notificationOn,
      vibrantOn: vibrantOn,
      ledOn: ledOn,
    );
    dynamic result = await settingService.setPushSetting(pushSetting);
    if (result['code'] == '1000') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thành công'),
            content: const Text('Cài đặt thông báo thành công!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Đóng'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Đóng'),
              ),
            ],
          );
        },
      );
    }
  }

  changeReturn(bool value) {
    if (value == false) {
      return '0';
    }
    return '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cài đặt'),
        ),
        body: FutureBuilder(
            future: _dataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading data'));
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bạn muốn nhận được thông báo từ ?',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(
                          color: Colors.black,
                        ),
                        SettingItem(
                          label: 'Like và bình luận',
                          value: likeComment,
                          onChanged: (value) {
                            setState(() {
                              likeComment = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 8.0),
                        SettingItem(
                          label: 'Bạn bè',
                          value: fromFriends,
                          onChanged: (value) {
                            setState(() {
                              fromFriends = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 8.0),
                        SettingItem(
                          label: 'Yêu cầu kết bạn',
                          value: requestedFriend,
                          onChanged: (value) {
                            setState(() {
                              requestedFriend = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 8.0),
                        SettingItem(
                          label: 'Gợi ý kết bạn',
                          value: suggestedFriend,
                          onChanged: (value) {
                            setState(() {
                              suggestedFriend = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 8.0),
                        SettingItem(
                          label: 'Sinh nhật',
                          value: birthday,
                          onChanged: (value) {
                            setState(() {
                              birthday = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 8.0),
                        SettingItem(
                          label: 'Video trực tiếp',
                          value: video,
                          onChanged: (value) {
                            setState(() {
                              video = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 8.0),
                        SettingItem(
                          label: 'Báo cáo',
                          value: report,
                          onChanged: (value) {
                            setState(() {
                              report = changeReturn(value);
                            });
                          },
                        ),
                        const Text(
                          'Bạn muốn nhận được thông báo như thế nào ?',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(
                          color: Colors.black,
                        ),
                        SettingItem(
                          label: 'Âm thanh',
                          value: soundOn,
                          onChanged: (value) {
                            setState(() {
                              soundOn = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 8.0),
                        SettingItem(
                          label: 'Thông báo',
                          value: notificationOn,
                          onChanged: (value) {
                            setState(() {
                              notificationOn = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 8.0),
                        SettingItem(
                          label: 'Rung',
                          value: vibrantOn,
                          onChanged: (value) {
                            setState(() {
                              vibrantOn = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 8.0),
                        SettingItem(
                          label: 'Đèn LED',
                          value: ledOn,
                          onChanged: (value) {
                            setState(() {
                              ledOn = changeReturn(value);
                            });
                          },
                        ),
                        const SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: setPushSetting,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: const Text('Lưu'),
                        )
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}

class SettingItem extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<bool> onChanged;

  const SettingItem({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  change(String value) {
    if (value == '0') {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(
          value: change(value),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
