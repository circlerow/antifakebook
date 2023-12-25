import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LikeRowWidget extends StatefulWidget {
  @override
  _LikeRowWidgetState createState() => _LikeRowWidgetState();
}

class _LikeRowWidgetState extends State<LikeRowWidget> {
  dynamic isFeltKudo = -1;

  void showReactionMenu(BuildContext context) async {
    final button = context.findRenderObject() as RenderBox;
    final buttonSize = button.size;
    final buttonPosition = button.localToGlobal(Offset.zero);

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final overlaySize = overlay.size;

    final menuWidth = 70.0;
    final menuHeight = 80.0;
    final borderRadius = BorderRadius.circular(15.0);

    final menuPositionX =
        (buttonPosition.dx + buttonSize.width / 2) - (menuWidth / 2);
    final menuPositionY = buttonPosition.dy - menuHeight - 10.0;

    final menuPosition = RelativeRect.fromLTRB(
      menuPositionX,
      menuPositionY,
      overlaySize.width - (menuPositionX + menuWidth),
      overlaySize.height - (menuPositionY + menuHeight),
    );

    await showMenu(
      context: context,
      position: menuPosition,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: Colors.grey.shade300),
      ),
      color: Colors.grey.shade100,
      items: [
        PopupMenuItem<String>(
          padding: const EdgeInsets.all(0),
          child: Container(
            width: menuWidth,
            height: menuHeight,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFeltKudo = '1';
                        });
                        Navigator.pop(context, '1');
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/img/reaction/like.gif',
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Like',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFeltKudo = '0';
                        });
                        Navigator.pop(context, '0');
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/img/reaction/love.gif',
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Love',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        // Thực hiện các hành động tương ứng (không cần setState vì đã thay đổi trạng thái trong GestureDetector)
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () async {
                  if (isFeltKudo == '1' || isFeltKudo == '0') {
                    // xử lý delete feel
                    //cập nhật lại trạng thái của isFeltKudo
                    setState(() {
                      isFeltKudo = '-1';
                    });
                  } else {
                    //cập nhật lại trạng thái của isFeltKudo
                    setState(() {
                      isFeltKudo = '1';
                    });
                  }
                },
                onLongPress: () {
                  // Xử lý khi nhấn giữ nút like
                  showReactionMenu(context);
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: () {
                        if (isFeltKudo == '-1') {
                          return Image.asset(
                            'assets/img/reaction/ic_like.png',
                            width: 20,
                            height: 20,
                          );
                        } else if (isFeltKudo == '0') {
                          return Image.asset(
                            'assets/img/reaction/love2.png',
                            width: 20,
                            height: 20,
                          );
                        } else {
                          return Image.asset(
                            'assets/img/reaction/ic_like_fill.png',
                            width: 20,
                            height: 20,
                          );
                        }
                      }(),
                    ),
                    () {
                      if (isFeltKudo == '-1') {
                        return const Text(
                          "Like",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        );
                      } else if (isFeltKudo == '0') {
                        return const Text(
                          "Phẫn nộ",
                          style: TextStyle(color: Colors.pink, fontSize: 16),
                        );
                      } else {
                        return const Text(
                          "Like",
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        );
                      }
                    }(),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                SizedBox(width: 5.0),
                Text('Comment', style: TextStyle(fontSize: 14.0)),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(FontAwesomeIcons.share, size: 20.0),
            SizedBox(width: 5.0),
            Text('Share', style: TextStyle(fontSize: 14.0)),
          ],
        ),
      ],
    );
  }
}
