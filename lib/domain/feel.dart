class FeelData {
  String id;
  Feel feel;

  FeelData({
    required this.id,
    required this.feel,
  });

  factory FeelData.fromJson(Map<String, dynamic> json) {
    return FeelData(
      id: json['id'] as String,
      feel: Feel.fromJson(json['feel'] as Map<String, dynamic>),
    );
  }
}

class Feel {
  User user;
  String type;

  Feel({
    required this.user,
    required this.type,
  });

  factory Feel.fromJson(Map<String, dynamic> json) {
    return Feel(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      type: json['type'] as String,
    );
  }
}

class User {
  String id;
  String name;
  String avatar;

  User({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    );
  }
}
