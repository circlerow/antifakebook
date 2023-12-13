import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application/models/user_notification.dart';

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();

    FirebaseMessaging.onMessage.listen((message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.notification!.title.toString()}');
      notifications.insert(
          0,
          UserNotification(
              imageUrl: 'assets/img/fb.jpg',
              content: message.notification!.title.toString(),
              time: "now"));
    });
    print('token $fCMToken');
  }
}
