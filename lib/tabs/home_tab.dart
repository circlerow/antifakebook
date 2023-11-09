import 'package:flutter_application/widgets/write_something_widget.dart';
import 'package:flutter_application/widgets/separator_widget.dart';
import 'package:flutter_application/widgets/post_widget.dart';
import 'package:flutter_application/widgets/stories_widget.dart';
import 'package:flutter_application/widgets/online_widget.dart';
import 'package:flutter_application/models/post.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          WriteSomethingWidget(),
          SeparatorWidget(),
          OnlineWidget(),
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
