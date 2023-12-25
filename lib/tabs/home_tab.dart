import 'package:flutter/material.dart';
import 'package:flutter_application/application/post_service.dart';
import 'package:flutter_application/data/post_repository.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/post_widget.dart';
import 'package:flutter_application/widgets/separator_widget.dart';
import 'package:flutter_application/widgets/write_something_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  HomeTabPage createState() => HomeTabPage();
}

class HomeTabPage extends State<HomeTab> {
  List<Post> posts = [];
  bool isLoading = false;
  int currentPage = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> fetchData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      PostService postService =
          PostService(postRepository: PostRepositoryImpl());

      List<Post> fetchedPosts = await postService.getListPost({
        "user_id": "",
        "in_campaign": "0",
        "campaign_id": "1",
        "latitude": "1.0",
        "longitude": "1.0",
        "last_id": "",
        "index": "$currentPage",
        "count": "20",
      });

      setState(() {
        posts.addAll(fetchedPosts);
        isLoading = false;
        currentPage += fetchedPosts.length;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: <Widget>[
          const WriteSomethingWidget(),
          const SeparatorWidget(),
          Column(
            children: <Widget>[
              for (Post post in posts)
                Column(
                  children: <Widget>[
                    const SeparatorWidget(),
                    PostWidget(post: post),
                  ],
                ),
              const SeparatorWidget(),
              if (isLoading) const CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
