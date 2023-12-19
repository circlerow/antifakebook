import 'package:flutter/material.dart';
import 'package:flutter_application/application/post_service.dart';
import 'package:flutter_application/data/post_repository.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/post_widget.dart';
import 'package:flutter_application/widgets/separator_widget.dart';
import 'package:flutter_application/widgets/video/video_post_widget.dart';

class VideoPage extends StatefulWidget {
  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  List<Post> posts = [];
  final ScrollController _scrollController = ScrollController();
  PostService postService = PostService(postRepository: PostRepositoryImpl());

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = 0.0; // or something else..
      if (maxScroll - currentScroll <= delta) {
        print("Loading more data...");
        _loadMoreData();
      }
    });
  }

  Future<void> fetchData() async {
    List<Post> fetchedPosts = await postService.getListVideos(3000, 3);
    setState(() {
      posts = fetchedPosts;
    });
  }

  Future<void> _loadMoreData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      List<Post> morePosts = await postService.getListVideos(
          int.parse(posts[posts.length - 1].id), 3);
      setState(() {
        posts.addAll(morePosts);
        _isLoading = false;
      });
    }
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
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            for (Post post in posts)
              Column(
                children: <Widget>[
                  const SeparatorWidget(),
                  VideoPostWidget(post: post)
                ],
              ),
            if (_isLoading)
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
