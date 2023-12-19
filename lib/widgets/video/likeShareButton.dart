import 'package:flutter/material.dart';

class LikeShareButton extends StatefulWidget {
  bool islike = false;

  @override
  _LikeShareButtonState createState() => _LikeShareButtonState();
}

class _LikeShareButtonState extends State<LikeShareButton> {
  Color likeButtonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
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
            ),
          ),
          Spacer(),
          Text('6 bình luận'),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    likeButtonColor = Colors.grey[400]!;
                  });
                },
                child: Container(
                  height: 30.0,
                  color: likeButtonColor,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/bar/likeButton.png',
                          width: 15,
                          height: 15,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Thích",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 30.0,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/bar/commentButton.png',
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          "Bình luận",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 30.0,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/bar/shareButton.png',
                          width: 15,
                          height: 15,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Chia sẻ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
