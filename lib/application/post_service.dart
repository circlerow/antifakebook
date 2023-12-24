import 'package:flutter_application/data/post_repository.dart';
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

  Future<Object> createPost(PostCreate body) async {
    dynamic data = await postRepository.createPost(body);
    if (data != false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('coin', int.parse(data['data']['coins']));
    }
    return data;
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
}
