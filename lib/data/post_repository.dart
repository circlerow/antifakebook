import 'dart:convert';
import 'dart:io';
import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;

import '../domain/post.dart';

abstract class PostRepository {
  Future<dynamic> getListPost(dynamic body);
  Future<dynamic> createPost(PostCreate body);
  Future<dynamic> deletePost(String id);
  Future<dynamic> feelPost(String id, String feel);
  Future<dynamic> deleteFell(String id);
  Future<dynamic> editPost(PostEdit postEdit);
  Future<dynamic> getListFeels(dynamic body);
  Future<dynamic> getListVideo(dynamic body);
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
  Future<dynamic> getListVideo(dynamic body) async {
    final http.Response response =
        await request('/get_list_videos', 'POST', isToken: true, body: body);
    return json.decode(response.body);
  }

  @override
  Future<dynamic> createPost(PostCreate postCreate) async {
    final http.StreamedResponse response = await addPostRequest(
        '/add_post', 'POST',
        isToken: true, postCreate: postCreate);
    Map<String, dynamic> data =
        json.decode(await response.stream.bytesToString());
    if (data["code"] == "1000") {
      return true;
    }
    return false;
  }

  @override
  Future<dynamic> deletePost(String id) async {
    final http.Response response =
        await request('/delete_post', 'POST', isToken: true, body: {"id":id});
    Map<String, dynamic> data = json.decode(response.body);
  }

  @override
  Future<dynamic> feelPost(String id, String feel) async {
    final http.Response response = await request(
        '/feel', 'POST',
        isToken: true, body: {"id": id, "type": feel});
    Map<String, dynamic> data = json.decode(response.body);
    if (data["code"] == "1000") {
      return true;
    }
    return false;
  }

  @override
  Future<dynamic> deleteFell(String id) async {
    final http.Response response = await request(
        '/delete_feel', 'POST',
        isToken: true, body: {"id": id});
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

  @override
  Future<dynamic> getListFeels(dynamic body) async {
    final http.Response response = await request('/get_list_feels', 'POST', isToken: true, body: body);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}