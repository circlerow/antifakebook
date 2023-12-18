import 'package:flutter/material.dart';
import 'package:flutter_application/application/post_service.dart';
import 'package:flutter_application/data/post_repository.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/post_widget.dart';
import 'package:flutter_application/widgets/video/video_post_widget.dart';

class VideoPage extends StatefulWidget {
  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    PostService postService = PostService(postRepository: PostRepositoryImpl());

    List<Post> fetchedPosts = await postService.getListVideos(1000, 3);
    setState(() {
      posts = fetchedPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Video',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          for (Post post in posts) VideoPostWidget(post: post),
        ]),
      ),
    );
  }
}
