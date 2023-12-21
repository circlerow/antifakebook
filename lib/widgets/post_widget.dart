import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/image_detail_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../presentation/friend/FriendInfo.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  PostWidget({required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  IconData selectedReaction = FontAwesomeIcons.thumbsUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FriendInfo(
                              friendId: widget.post.author.id,
                            )),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.author.avatar),
                  radius: 20.0,
                ),
              ),
              const SizedBox(width: 7.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.post.author.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(formatTimeDifference(widget.post.created)),
                ],
              ),
              const Spacer(), // Để tạo khoảng trống giữa Column và PopupMenuButton
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      child: Text('Chỉnh sửa bài'),
                      value: 'edit',
                    ),
                    const PopupMenuItem(
                      child: Text('Xóa bài'),
                      value: 'delete',
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 'edit') {
                    // Xử lý sự kiện chỉnh sửa bài
                  } else if (value == 'delete') {
                    // Xử lý sự kiện xóa bài
                  }
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
                children: convertUrlsToTextSpans(widget.post.described),
                style: TextStyle(
                  color: Colors.black,
                )),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            child: widget.post.images.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Số lượng ảnh trên một hàng
                      mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
                      crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
                      childAspectRatio:
                          1.0, // Tỉ lệ giữa chiều rộng và chiều dài của ảnh
                    ),
                    itemCount: widget.post.images.length,
                    itemBuilder: (context, index) {
                      // return Image.network(
                      //   widget.post.images[index].url,
                      //   fit: BoxFit.cover,
                      // );
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDetailPage(
                                imageUrl: widget.post.images[index].url,
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          widget.post.images[index].url,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(FontAwesomeIcons.thumbsUp,
                      size: 15.0, color: Colors.blue),
                  Text(' ${widget.post.feel}'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('${widget.post.commentMark} comments  •  '),
                ],
              ),
            ],
          ),
          const Divider(height: 30.0),
          Row(
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
                                  'assets/like.png',
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
                                  'assets/liked.png',
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
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              );
                            } else if (isFeltKudo == '0') {
                              return const Text(
                                "Phẫn nộ",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return const Text(
                                "Like",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Comments',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Icon(FontAwesomeIcons.thumbsUp,
                                              size: 15.0, color: Colors.blue),
                                          Text(' ${widget.post.feel}'),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                              '${widget.post.commentMark} comments  •  '),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                    width: 500,
                                  ),
                                  Container(
                                    height: 200.0,
                                    width: 500,
                                    child: PageView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return const Text(
                                          "Comment",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: 'Write a comment...',
                                              fillColor: Colors.black),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.send),
                                        onPressed: () {
                                          // Xử lý khi người dùng gửi bình luận
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        //Icon(FontAwesomeIcons.commentAlt, size: 20.0),

                        Image.asset('assets/comment.png',
                            width: 20.0, height: 20.0),
                        const SizedBox(width: 5.0),
                        const Text('Comment',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Image.asset('assets/share.png', width: 20.0, height: 20.0),
                  const SizedBox(width: 5.0),
                  const Text('Share',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String formatTimeDifference(String createdString) {
    DateTime createdAt = DateTime.parse(createdString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'Vừa xong';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 31) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months tháng trước';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years năm trước';
    }
  }

  List<TextSpan> convertUrlsToTextSpans(String text) {
    List<TextSpan> textSpans = [];
    RegExp urlRegex = RegExp(
      r"(http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+)",
      multiLine: true,
    );

    Iterable<RegExpMatch> matches = urlRegex.allMatches(text);

    if (matches.isNotEmpty) {
      int previousEnd = 0;

      for (RegExpMatch match in matches) {
        if (match.start > previousEnd) {
          String nonUrlText = text.substring(previousEnd, match.start);
          textSpans.add(
            TextSpan(text: nonUrlText),
          );
        }

        String url = match.group(0)!;

        textSpans.add(
          TextSpan(
            text: url,
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(url);
              },
          ),
        );

        previousEnd = match.end;
      }

      if (previousEnd < text.length) {
        String remainingText = text.substring(previousEnd);
        textSpans.add(
          TextSpan(text: remainingText),
        );
      }
    } else {
      textSpans.add(
        TextSpan(text: text),
      );
    }

    return textSpans;
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  dynamic isFeltKudo = -1;

  void showReactionMenu(BuildContext context) {
    // Get the position of the button
    // RenderBox button = context.findRenderObject() as RenderBox;
    // Offset buttonPosition = button.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(-80, 315, 0, 0),
      // position: RelativeRect.fromLTRB(
      //   buttonPosition.dx,
      //   buttonPosition.dy + button.size.height+300,
      //   buttonPosition.dx + button.size.width,
      //   buttonPosition.dy + button.size.height, // Height of the menu
      // ),
      elevation: 0,
      // Đặt độ nâng của PopupMenu để loại bỏ border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Đặt độ cong của border
      ),
      color: Colors.transparent,
      // color: Colors.blue,
      items: [
        PopupMenuItem<String>(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PopupMenuItem<String>(
                padding: const EdgeInsets.all(0),
                value: '1',
                child: Image.asset(
                  'assets/img/reaction/like.gif',
                  width: 30,
                  height: 30,
                ),
              ),
              PopupMenuItem<String>(
                padding: const EdgeInsets.all(0),
                value: '0',
                child: Image.asset(
                  'assets/img/reaction/love.gif',
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    ).then((value) async {
      if (value != null) {
        setState(() {
          isFeltKudo = value == '1' ? '1' : '0';
        });
        // Thực hiện các hành động tương ứng
      }
    });
  }
}
