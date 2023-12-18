import 'package:flutter_application/application/notification_service.dart';
import 'package:flutter_application/domain/notification.dart';
import 'package:flutter_application/models/user_notification.dart';

class NotificationController {
  static late List<Noti> notifications;

  NotificationService notificationService = new NotificationService();

  NotificationController() {
    notifications = [];
    init();
  }

  Future<void> init() async {
    notifications = await notificationService.getNotifications(1, 10);
    print("DONE");
    print("DONE");
    print("DONE");
  }

  static void addNotification(Noti noti) {
    notifications.insert(0, noti);
  }
}
