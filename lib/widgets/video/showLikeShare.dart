import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/post_widget.dart';
import 'package:flutter_application/widgets/video/like.dart';

class LikeShareBar extends StatefulWidget {
  @override
  _LikeShareState createState() => _LikeShareState();
}

class _LikeShareState extends State<LikeShareBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Like(),
          ),
          Spacer(),
          Text('6 bình luận'),
        ],
      ),
    );
  }
}
