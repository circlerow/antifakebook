import 'package:flutter_application/application/notification_service.dart';
import 'package:flutter_application/domain/notification.dart';

class NotificationController {
  static NotificationController? _instance;
  static bool _isInitialized = false;

  late List<Noti> notifications;
  NotificationService notificationService = new NotificationService();

  factory NotificationController() {
    if (_instance == null) {
      _instance = NotificationController._internal();
    }
    return _instance!;
  }

  Future<void> init() async {
    notifications = await notificationService.getNotifications(1, 10);
    print("DONE");
    print("DONE");
    print("DONE");
  }

  NotificationController._internal() {
    init();
    if (!_isInitialized) {
      _initialize();
    }
  }

  Future<void> _initialize() async {
    notifications = await notificationService.getNotifications(1, 10);
    _isInitialized = true;
    print("Initialization complete");
  }

  void addNotification(Noti noti) {
    this.notifications.insert(0, noti);
  }
}
