import 'package:flutter_application/data/post_repository.dart';
import 'package:flutter_application/domain/feel.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostService {
  final PostRepository postRepository;

  PostService({required this.postRepository});

  Future<List<Post>> getListPost(dynamic body) async {
    dynamic data = await postRepository.getListPost(body);
    Map<String, dynamic> dataPost = data["data"];
    List<dynamic> postsJson = dataPost['post'] ?? [];
    return postsJson.map((postJson) => Post.fromJson(postJson)).toList();
  }

  Future<List<Post>> getListVideos(int lastId, int count) async {
    dynamic body = {
      "user_id": "",
      "in_campaign": "1",
      "campaign_id": "1",
      "latitude": "1.0",
      "longitude": "1.0",
      "last_id": lastId.toString(),
      "index": "0",
      "count": count.toString()
    };
    dynamic data = await postRepository.getListVideo(body);
    Map<String, dynamic> dataPost = data["data"];
    List<dynamic> postsJson = dataPost['post'] ?? [];
    return postsJson.map((e) => Post.fromJson(e)).toList();
  }

  Future<Object> createPost(PostCreate body) async {
    dynamic data = await postRepository.createPost(body);
    if (data != false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('coin', int.parse(data['data']['coins']));
    }
    return data;
  }

  Future<bool> deletePost(String id) async {
    return await postRepository.deletePost(id);
  }

  Future<bool> feelPost(String id, String feel) async {
    dynamic data = await postRepository.feelPost(id, feel);
    if (data != false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('coin', int.parse(data['coins']));
    }
    return data;
  }

  Future<bool> deleteFell(String id) async {
    return await postRepository.deleteFell(id);
  }

  Future<bool> editPost(PostEdit postEdit) async {
    return await postRepository.editPost(postEdit);
  }

  Future<List<FeelData>> getListFeels(dynamic body) async {
    dynamic data = await postRepository.getListFeels(body);
    List<dynamic> dataFeel = data["data"];
    return dataFeel.map((dataFeel) => FeelData.fromJson(dataFeel)).toList();
  }

  Future<Post> getPost(String id) async {
    dynamic body = {"id": id};

    dynamic data = await postRepository.getPost(body);
    return Post.fromJson(data['data']);
  }
}
