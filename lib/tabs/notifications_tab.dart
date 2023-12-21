import 'package:flutter/material.dart';
import 'package:flutter_application/controller/notificationController.dart';
import 'package:flutter_application/domain/notification.dart';
import 'package:flutter_application/widgets/notification_widget.dart';

import '../widgets/separator_widget.dart';

class NotificationsTab extends StatefulWidget {
  late NotificationController ctrl;
  NotificationsTab({Key? key, required this.ctrl}) : super(key: key);

  @override
  _NotificationsTabState createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  List<Notification> notifications = []; // Đặt danh sách thông báo ở đây

  @override
  Widget build(BuildContext context) {
    print(" RUN ================ ");
    print(" RUN ================ ");
    print(" RUN ================ ");
    print(" So luong thong bao hien tai " +
        widget.ctrl.notifications.length.toString());

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
              child: Text(
                'Notifications',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            for (Noti notification in widget.ctrl.notifications)
              Column(
                children: [
                  NotificationWidget(noti: notification),
                ],
              )
          ],
        ),
      ),
    );
  }
}
