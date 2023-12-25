import 'package:flutter_application/data/notification_repository.dart';
import 'package:flutter_application/domain/notification.dart';

class NotificationService {
  final NotificationRepository repository = new NotificationRepositoryImpl();

  Future<List<Noti>> getNotifications(int index, int count) async {
    dynamic body = {
      "index": index.toString(),
      "count": count.toString(),
    };

    dynamic res = await repository.getNotifications(body);
    List<dynamic> data = res["data"];

    return data.map((postJson) => Noti.fromJson(postJson)).toList();
  }
}
