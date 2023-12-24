import 'package:flutter_application/data/auth_repository.dart';
import 'package:flutter_application/data/comment_repository.dart';
import 'package:flutter_application/domain/comment.dart';
import 'package:flutter_application/domain/user_login.dart';
import 'package:flutter_application/domain/user_signup.dart';
import '../domain/change_info_after_signup.dart';

class CommentService {
  final CommentRepository repo;

  CommentService({required this.repo});

  Future<List<Comment>> getMarkComment(int id, int count) async {
    dynamic body = {
      "id": id.toString(),
      "index": "0",
      "count": count.toString(),
    };

    dynamic res = await repo.getMarkComment(body);

    List<Comment> commentList = [];
    for (var commentJson in res['data']) {
      Comment comment = Comment.fromJson(commentJson);
      commentList.add(comment);
    }

    return commentList;
  }

  Future<List<Comment>> addMark(
    String id_bai_viet,
    String noi_dung,
  ) async {
    dynamic body = {
      "id": id_bai_viet,
      "content": noi_dung,
      "index": "0",
      "count": "100",
      "mark_id": "",
      "type": "0"
    };
    print("id = " + id_bai_viet + " noi dung = " + noi_dung);
    dynamic res = await repo.setMarkComment(body);
    List<Comment> commentList = [];
    for (var commentJson in res['data']) {
      Comment comment = Comment.fromJson(commentJson);
      commentList.add(comment);
    }

    return commentList;
  }

  Future<List<Comment>> addComment(
    String id_bai_viet,
    String id_mark,
    String noi_dung,
  ) async {
    dynamic body = {
      "id": id_bai_viet,
      "content": noi_dung,
      "index": "0",
      "count": "100",
      "mark_id": id_mark,
      "type": "1"
    };

    dynamic res = await repo.setMarkComment(body);
    List<Comment> commentList = [];
    for (var commentJson in res['data']) {
      Comment comment = Comment.fromJson(commentJson);
      commentList.add(comment);
    }
    return commentList;
  }
}
