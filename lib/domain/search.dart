import 'post.dart';

class SaveSearch {
  final String id;
  final String keyword;
  final String created;

  SaveSearch({
    required this.id,
    required this.keyword,
    required this.created,
  });

  factory SaveSearch.fromJson(Map<String, dynamic> json) {
    return SaveSearch(
      id: json['id'] ?? '',
      keyword: json['keyword'] ?? '',
      created: json['created'] ?? '',
    );
  }
}

class Search {
  final String id;
  final String name;
  final List<ImageInfo> images;
  final String described;
  final String created;
  final String feel;
  final String markComment;
  final String isFelt;
  final String state;
  final Author author;

  Search(
      {required this.id,
      required this.name,
      required this.images,
      required this.described,
      required this.created,
      required this.feel,
      required this.markComment,
      required this.isFelt,
      required this.state,
      required this.author});

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      images: (json['image'] as List<dynamic>?)
              ?.map((imageJson) => ImageInfo.fromJson(imageJson))
              .toList() ??
          [],
      described: json['described'] ?? '',
      created: json['created'] ?? '',
      feel: json['feel'] ?? '',
      markComment: json['mark_comment'] ?? '',
      isFelt: json['is_felt'] ?? '',
      state: json['state'] ?? '',
      author: Author.fromJson(json['author'] ?? {}),
    );
  }

}
