class Friend {
  final String id;
  final String username;
  final String avatar;
  final int sameFriends;
  final DateTime created;

  Friend({
    required this.id,
    required this.username,
    required this.avatar,
    required this.sameFriends,
    required this.created,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      avatar: json['avatar'] ?? '',
      sameFriends: int.parse(json['same_friends'] ?? '0'),
      created: DateTime.parse(json['created'] ?? ''),
    );
  }
}
