import 'package:flutter_application/data/post_repository.dart';
import 'package:flutter_application/domain/post.dart';

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

  Future<bool> createPost(PostCreate body) async {
    return await postRepository.createPost(body);
  }
}
