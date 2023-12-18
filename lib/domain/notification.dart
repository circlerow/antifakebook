enum NotificationType {
  FriendRequest,
  FriendAccept,
  PostAdded,
  PostUpdated,
  PostFelt,
  PostMarkd,
  MarkCommented,
  VideoAdded,
  PostCommented
}

class Noti {
  NotificationType type;
  String objectId;
  String title;
  String notification_id;
  DateTime created;
  String avatar;
  String group;
  String read;
  NotiPost? post;
  NotiUser? user;
  NotiMark? mark;
  NotiFeel? feel;

  Noti({
    required this.type,
    required this.objectId,
    required this.title,
    required this.notification_id,
    required this.created,
    required this.avatar,
    required this.group,
    required this.read,
    required this.user,
    required this.post,
    required this.mark,
    required this.feel,
  });

  factory Noti.fromJson(Map<String, dynamic> json) {
    return Noti(
        type: _parseNotificationType(json['type'] ?? ''),
        objectId: json['object_id'] ?? '',
        title: json['title'] ?? '',
        notification_id: json['notification_id'] ?? '',
        created: DateTime.parse(json['created'] ?? ''),
        avatar: json['avatar'] ?? '',
        group: json['group'] ?? '',
        read: json['read'] ?? '',
        user: NotiUser.fromJson(json['user'] ?? {}),
        post: NotiPost.fromJson(json['post'] ?? {}),
        mark: NotiMark.fromJson(json['mark'] ?? {}),
        feel: NotiFeel.fromJson(json['feel'] ?? {}));
  }

  static NotificationType _parseNotificationType(String value) {
    switch (value) {
      case '1':
        return NotificationType.FriendRequest;
      case '2':
        return NotificationType.FriendAccept;
      case '3':
        return NotificationType.PostAdded;
      case '4':
        return NotificationType.PostUpdated;
      case '5':
        return NotificationType.PostFelt;
      case '6':
        return NotificationType.PostMarkd;
      case '7':
        return NotificationType.MarkCommented;
      case '8':
        return NotificationType.VideoAdded;
      case '9':
        return NotificationType.PostCommented;
      default:
        throw Exception('Unknown notification type: $value');
    }
  }
}

class NotiUser {
  String id;
  String username;
  String avatar;
  NotiUser({required this.id, required this.username, required this.avatar});

  factory NotiUser.fromJson(Map<String, dynamic> json) {
    return NotiUser(
        id: json["id"] ?? '',
        username: json["username"] ?? 'MockName',
        avatar: json["avatar"] ?? '');
  }
}

class NotiPost {
  String id;
  String described;
  String status;

  NotiPost({required this.id, required this.described, required this.status});

  factory NotiPost.fromJson(Map<String, dynamic> json) {
    return NotiPost(
        id: json["id"] ?? '',
        described: json["described"] ?? '',
        status: json["status"] ?? '');
  }
}

class NotiMark {
  String id;
  String type;
  String content;

  NotiMark({required this.id, required this.type, required this.content});

  factory NotiMark.fromJson(Map<String, dynamic> json) {
    return NotiMark(
        id: json["id"] ?? '',
        type: json["type"] ?? '',
        content: json["content"] ?? '');
  }
}

class NotiFeel {
  String id;
  String type;
  NotiFeel({required this.id, required this.type});

  factory NotiFeel.fromJson(Map<String, dynamic> json) {
    return NotiFeel(id: json["id"] ?? '', type: json["type"] ?? '');
  }
}
