import 'dart:convert';

import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

import '../domain/post.dart';

abstract class PostRepository {
  Future<dynamic> getListPost(dynamic body);
  Future<dynamic> createPost(PostCreate body);
  Future<dynamic> feelPost(String id, String feel);
  Future<dynamic> deleteFell(String id);
  Future<dynamic> editPost(PostEdit postEdit);
}

class PostRepositoryImpl implements PostRepository {
  @override
  Future<dynamic> getListPost(dynamic body) async {
    final http.Response response =
        await request('/get_list_posts', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);

    return data;
  }

  @override
  Future<dynamic> createPost(PostCreate postCreate) async {
    final http.StreamedResponse response = await addPostRequest(
        '/add_post', 'POST',
        isToken: true, postCreate: postCreate);
    Map<String, dynamic> data =
        json.decode(await response.stream.bytesToString());
    if (data["code"] == "1000") {
      return data;
    }
    return false;
  }

  @override
  Future<dynamic> feelPost(String id, String feel) async {
    final http.Response response = await request('/feel', 'POST',
        isToken: true, body: {"id": id, "type": feel});
    Map<String, dynamic> data = json.decode(response.body);
    if (data["code"] == "1000") {
      return data;
    }
    return false;
  }

  @override
  Future<dynamic> deleteFell(String id) async {
    final http.Response response =
        await request('/delete_feel', 'POST', isToken: true, body: {"id": id});
    Map<String, dynamic> data = json.decode(response.body);
    if (data["code"] == "1000") {
      return true;
    }
    return false;
  }

  @override
  Future<dynamic> editPost(PostEdit postEdit) async {
    final http.StreamedResponse response = await editPostRequest(
        '/edit_post', 'POST',
        isToken: true, postEdit: postEdit);
    Map<String, dynamic> data =
        json.decode(await response.stream.bytesToString());
    if (data["code"] == "1000") {
      return true;
    }
    return false;
  }
}
