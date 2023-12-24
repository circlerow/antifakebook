class Comment {
  final String id;
  final String mark_content;
  final DateTime createAt;
  final Poster poster;
  final List<ChildComment> childComment;

  Comment(
      {required this.id,
      required this.mark_content,
      required this.createAt,
      required this.poster,
      required this.childComment});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? '',
      mark_content: json['mark_content'] ?? '',
      createAt: DateTime.parse(json['created'] ?? ''),
      poster: Poster.fromJson(json['poster'] ?? {}),
      childComment: (json['comments'] as List<dynamic>?)?.map((commentJson) {
            return ChildComment.fromJson(commentJson as Map<String, dynamic>);
          }).toList() ??
          [],
    );
  }
}

class Poster {
  String id;
  String name;
  String avatar;
  Poster({required this.id, required this.name, required this.avatar});

  factory Poster.fromJson(Map<String, dynamic> json) {
    return Poster(
        id: json["id"] ?? '',
        name: json["name"] ?? 'MockName',
        avatar: json["avatar"] ?? '');
  }
}

class ChildComment {
  final String content;
  final DateTime created;
  final Poster poster;

  ChildComment(
      {required this.content, required this.created, required this.poster});

  factory ChildComment.fromJson(Map<String, dynamic> json) {
    return ChildComment(
      content: json['content'] ?? '',
      created: DateTime.parse(json['created'] ?? ''),
      poster: Poster.fromJson(json['poster'] ?? {}),
    );
  }
}
