import 'package:flutter/material.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/post/reactionButton2.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class LikeShareButton extends StatefulWidget {
  bool islike = false;
  late Post post;

  LikeShareButton({required this.post});

  @override
  _LikeShareButtonState createState() => _LikeShareButtonState();
}

class _LikeShareButtonState extends State<LikeShareButton> {
  late dynamic isLike = int.parse(widget.post.isFelt);

  Color likeButtonColor = Colors.white;
  final GlobalKey<ReactionButtonState> childKey = GlobalKey();

  @override
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
                child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                childKey.currentState!.show();
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ReactionButton2<String>(
                  hoverDuration: const Duration(milliseconds: 1000),
                  key: childKey,
                  toggle: false,
                  direction: ReactionsBoxAlignment.rtl,
                  onReactionChanged: (Reaction<String>? reaction) {},
                  reactions: <Reaction<String>>[
                    Reaction<String>(
                      value: 'like',
                      icon: Image.asset(
                        'assets/img/bar/like.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                    Reaction<String>(
                      value: 'love',
                      icon: Image.asset(
                        'assets/img/bar/love.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                  placeholder: Reaction<String>(
                      value: null,
                      icon: Row(
                        children: [],
                      )),
                  boxColor:
                      const Color.fromARGB(255, 250, 250, 250).withOpacity(1),
                  boxRadius: 90,
                  itemsSpacing: 20,
                  itemSize: const Size(60, 60),
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Thích',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              ]),
            )),
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
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                alignment: Alignment.center,
                width: (MediaQuery.of(context).size.width) / 3,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage('assets/img/bar/shareButton.png'),
                      size: 27,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Chia sẻ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ]),
    );
  }
}
