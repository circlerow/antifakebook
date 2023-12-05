import 'package:flutter_application/application/post_service.dart';
import 'package:flutter_application/data/post_repository.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/write_something_widget.dart';
import 'package:flutter_application/widgets/separator_widget.dart';
import 'package:flutter_application/widgets/post_widget.dart';
import 'package:flutter_application/widgets/stories_widget.dart';
import 'package:flutter_application/widgets/online_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget{
  @override
  HomeTabPage createState() => HomeTabPage();
}

class HomeTabPage extends State<HomeTab> {
  
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    PostService postService = PostService(postRepository: PostRepositoryImpl());
    List<Post> fetchedPosts = await postService.getListPost({
      "user_id": "1",
      "in_campaign": "1",
      "campaign_id": "1",
      "latitude": "1.0",
      "longitude": "1.0",
      "last_id": "0",
      "index": "0",
      "count": "20"
    });

    setState(() {
      posts = fetchedPosts;
      print(posts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          WriteSomethingWidget(),
          //SeparatorWidget(),
          //OnlineWidget(),
          SeparatorWidget(),
          StoriesWidget(),
          for (Post post in posts)
            Column(
              children: <Widget>[
                SeparatorWidget(),
                PostWidget(post: post),
              ],
            ),
          SeparatorWidget(),
        ],
      ),
    );
  }
}
