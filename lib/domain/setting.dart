class PushSetting {
  final String likeComment;
  final String fromFriends;
  final String requestedFriend;
  final String suggestedFriend;
  final String birthday;
  final String video;
  final String report;
  final String soundOn;
  final String notificationOn;
  final String vibrantOn;
  final String ledOn;


  PushSetting({
    required this.likeComment,
    required this.fromFriends,
    required this.requestedFriend,
    required this.suggestedFriend,
    required this.birthday,
    required this.video,
    required this.report,
    required this.soundOn,
    required this.notificationOn,
    required this.vibrantOn,
    required this.ledOn,
  });

  factory PushSetting.fromJson(Map<String, dynamic> json) {
    return PushSetting(
      likeComment: json['like_comment'] ?? '0',
      fromFriends: json['from_friends'] ?? '0',
      requestedFriend: json['requested_friend'] ?? '0',
      suggestedFriend: json['suggested_friend'] ?? '0',
      birthday: json['birthday'] ?? '0',
      video: json['video'] ?? '0',
      report: json['report'] ?? '0',
      soundOn: json['sound_on'] ?? '0',
      notificationOn: json['notification_on'] ?? '0',
      vibrantOn: json['vibrant_on'] ?? '0',
      ledOn: json['led_on'] ?? '0',
    );
  }
}
