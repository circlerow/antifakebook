class Post {
  final String id;
  final String name;
  final List<ImageInfo> images;
  final String described;
  final String created;
  final String feel;
  final String commentMark;
  final String isFelt;
  final String isBlocked;
  final String canEdit;
  final String banned;
  final String state;
  final Author author;

  Post({
    required this.id,
    required this.name,
    required this.images,
    required this.described,
    required this.created,
    required this.feel,
    required this.commentMark,
    required this.isFelt,
    required this.isBlocked,
    required this.canEdit,
    required this.banned,
    required this.state,
    required this.author,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      images: (json['image'] as List<dynamic>?)
          ?.map((imageJson) => ImageInfo.fromJson(imageJson))
          .toList() ??
          [],
      described: json['described'] ?? '',
      created: json['created'] ?? '',
      feel: json['feel'] ?? '',
      commentMark: json['comment_mark'] ?? '',
      isFelt: json['is_felt'] ?? '',
      isBlocked: json['is_blocked'] ?? '',
      canEdit: json['can_edit'] ?? '',
      banned: json['banned'] ?? '',
      state: json['state'] ?? '',
      author: Author.fromJson(json['author'] ?? {}),
    );
  }
}

class ImageInfo {
  final String id;
  final String url;

  ImageInfo({
    required this.id,
    required this.url,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class Author {
  final String id;
  final String name;
  final String avatar;

  Author({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}