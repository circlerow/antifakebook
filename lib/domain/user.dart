class User {
  final String id;
  final String username;
  final DateTime created;
  String description;
  final String avatar;
  final String coverImage;
  final String link;
  String address;
  final String city;
  String country;
  final String listing;
  final String isFriend;
  final String online;
  final String coins;

  User({
    required this.id,
    required this.username,
    required this.created,
    required this.description,
    required this.avatar,
    required this.coverImage,
    required this.link,
    required this.address,
    required this.city,
    required this.country,
    required this.listing,
    required this.isFriend,
    required this.online,
    required this.coins,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? "",
      username: json['username'] ?? "",
      created: DateTime.parse(json['created'] ?? ""),
      description: json['description'] ?? "",
      avatar: json['avatar'] ?? "",
      coverImage: json['cover_image'] ?? "",
      link: json['link'] ?? "",
      address: json['address'] ?? "",
      city: json['city'] ?? "",
      country: json['country'] ?? "",
      listing: json['listing'] ?? "",
      isFriend: json['is_friend'] ?? "",
      online: json['online'] ?? "",
      coins: json['coins'] ?? "",
    );
  }
}
