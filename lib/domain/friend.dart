class Friend {
  final String id;
  final String username;
  final String avatar;
  final String sameFriends;
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
      sameFriends: json['same_friends'] ?? '0',
      created: DateTime.parse(json['created'] ?? ''),
    );
  }
}


class Block{
  final String id;
  final String name;
  final String avatar;

  Block({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
