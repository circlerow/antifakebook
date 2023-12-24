import 'dart:io';

import 'package:flutter_application/application/comment_service.dart';
import 'package:flutter_application/domain/comment.dart';

class Post {
  final String id;
  final String name;
  final List<ImageInfo> images;
  final VideoInfo video;
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
  late List<Comment> comments = [];

  late int kudos;
  late int disappointed;

  Post({
    required this.id,
    required this.name,
    required this.images,
    required this.video,
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
    var id = json['id'] ?? '';

    return Post(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      images: (json['image'] as List<dynamic>?)
              ?.map((imageJson) => ImageInfo.fromJson(imageJson))
              .toList() ??
          [],
      video: VideoInfo.fromJson(json['video'] ?? {}),
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': images,
      'described': described,
      'created': created,
      'feel': feel,
      'comment_mark': commentMark,
      'is_felt': isFelt,
      'is_blocked': isBlocked,
      'can_edit': canEdit,
      'banned': banned,
      'state': state,
      'author': author,
    };
  }

  Future<void> addMark(
    CommentService service,
    String id_bai_viet,
    String noi_dung,
  ) async {
    List<Comment> newComments = await service.addMark(id_bai_viet, noi_dung);
    this.comments = newComments;
  }

  Future<void> addComment(
    CommentService service,
    String id_bai_viet,
    String id_mark,
    String noi_dung,
  ) async {
    List<Comment> newComments =
        await service.addComment(id_bai_viet, id_mark, noi_dung);
    this.comments = newComments;
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

class VideoInfo {
  final String url;

  VideoInfo({required this.url});

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(url: json['url'] ?? '');
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

class PostCreate {
  final List<File>? image;
  final File? video;
  final String? described;
  final String? status;
  final String? autoAccept;

  PostCreate({
    required this.image,
    required this.video,
    required this.described,
    required this.status,
    required this.autoAccept,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'video': video,
      'described': described,
      'status': status,
      'auto_accept': autoAccept,
    };
  }
}

class PostEdit {
  final String id;
  final List<File>? image;
  final File? video;
  final String? described;
  final String? status;
  final String? autoAccept;
  final String? imageDelete;

  PostEdit({
    required this.id,
    required this.image,
    required this.video,
    required this.described,
    required this.status,
    required this.autoAccept,
    this.imageDelete,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'video': video,
      'described': described,
      'status': status,
      'auto_accept': autoAccept,
      'image_del': imageDelete,
    };
  }
}
