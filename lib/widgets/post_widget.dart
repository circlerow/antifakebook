import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/application/post_service.dart';
import 'package:flutter_application/data/post_repository.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/image_detail_page.dart';
import 'package:flutter_application/widgets/post_detail_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../application/post_service.dart';
import '../data/post_repository.dart';
import '../presentation/friend/FriendInfo.dart';
import '../presentation/post/edit_post.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  IconData selectedReaction = FontAwesomeIcons.thumbsUp;

  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  late String isFeltKudo;
  final PostService postService =
      PostService(postRepository: PostRepositoryImpl());

  @override
  void initState() {
    super.initState();
    isFeltKudo = widget.post.isFelt;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: widget.post.author.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.black,
                          ),
                        ),
                        if (widget.post.state != '')
                          TextSpan(
                            text: " - Đang cảm thấy ${widget.post.state}",
                            style: const TextStyle(
                              fontSize: 12.0, // Đặt kích thước font chữ nhẹ hơn
                              color: Colors.grey, // Đặt màu chữ nhẹ hơn
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    formatTimeDifference(widget.post.created),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  if (widget.post.canEdit == '1') {
                    return [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Chỉnh sửa bài'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Xóa bài'),
                      ),
                    ];
                  } else {
                    return [
                      const PopupMenuItem(
                        value: 'report',
                        child: Text('Báo cáo'),
                      ),
                    ];
                  }
                },
                onSelected: (value) {
                  if (value == 'edit') {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditPost(post: widget.post),
                        ),
                      );
                  } else if (value == 'delete') {
                    // Xử lý sự kiện xóa bài
                    postService.deletePost(widget.post.id);
                  } else if (value == 'report') {
                    // Xử lý sự kiện báo cáo
                  }
                },
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: convertUrlsToTextSpans(widget.post.described),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDetailPage(
                                imageUrls: widget.post.images,
                                initialIndex: index,
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
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(FontAwesomeIcons.thumbsUp,
                        size: 15.0, color: Colors.blue),
                  ),
                  Text(' ${widget.post.feel}'),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: Text('${widget.post.commentMark} comments  •  '),
                  )
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
                  LongPressDraggable(
                    data: "drag_data", // You can set any data you need to pass
                    onDragStarted: () {
                      _showReactionMenu(context);
                    },
                    feedback: Container(
                      // Provide a simple feedback appearance, you can customize this
                      width: 50,
                      height: 50,
                      color: Colors.blue,
                    ),
                    childWhenDragging: Container(),
                    child: GestureDetector(
                      key: _buttonKey,
                      onTap: () async {
                        if (isFeltKudo == '1' || isFeltKudo == '0') {
                          setState(() {
                            isFeltKudo = '-1';
                          });
                          await postService.deleteFell(widget.post.id);
                        } else {
                          setState(() {
                            isFeltKudo = '1';
                          });
                          await postService.feelPost(widget.post.id, '1');
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            getKudoImage(),
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            getKudoText(),
                            style: TextStyle(
                              color: getKudoColor(),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PostDetailsPage(post: widget.post),
                        ),
                      );
                    },
                    child: Row(
                      children: <Widget>[
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
              )
            ],
          ),
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
    } else if (difference.inMinutes >= 1 && difference.inMinutes <= 60) {
      return '${difference.inMinutes} phút trước';
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

  String getKudoImage() {
    switch (isFeltKudo) {
      case '-1':
        return 'assets/like.png';
      case '0':
        return 'assets/dislike.png';
      default:
        return 'assets/liked.png';
    }
  }

  String getKudoText() {
    switch (isFeltKudo) {
      case '-1':
        return 'Fell';
      case '0':
        return 'Disappointed';
      default:
        return 'Kudos';
    }
  }

  Color getKudoColor() {
    switch (isFeltKudo) {
      case '-1':
        return Colors.black;
      case '0':
        return Colors.pink;
      default:
        return Colors.blue;
    }
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showReactionMenu(BuildContext context) {
    if (_overlayEntry != null) {
      // If the overlay is already visible, remove it
      _overlayEntry!.remove();
      _overlayEntry = null;
      return;
    }

    final RenderBox buttonBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = buttonBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: buttonPosition.dy - 60.0,
        left: buttonPosition.dx - 20.0,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMenuItem(
                    Image.asset('assets/liked.png', width: 23, height: 23),
                    '1'),
                _buildMenuItem(
                    Image.asset('assets/dislike.png', width: 23, height: 23),
                    '0'),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildMenuItem(Image iconData, String value) {
    return InkWell(
      onTap: () async {
        await postService.feelPost(widget.post.id, value);
        setState(() {
          isFeltKudo = value;
        });
        _overlayEntry!.remove();
        _overlayEntry = null;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            iconData,
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }
}
