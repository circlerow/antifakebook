import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/post_widget.dart';

class Like extends StatefulWidget {
  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/bar/like.png'),
                fit: BoxFit.cover,
              ),
            ),
            height: 30,
            width: 30,
          ),
          Positioned(
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/bar/share.png'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      height: 30,
      width: 60,
    );
  }
}
