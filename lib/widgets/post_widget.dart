import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:flutter_application/presentation/friend/FriendInfo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  _PostWidgetPage createState() => _PostWidgetPage();
}

class _PostWidgetPage extends State<PostWidget> {
  UserService userService = UserService(userRepository: UserRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              User res = await userService.getUserInfo(widget.post.author.id);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FriendInfo(
                          friend: res,
                        )),
              );
            },
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.author.avatar),
                  radius: 20.0,
                ),
                const SizedBox(width: 7.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.post.author.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0)),
                    const SizedBox(height: 5.0),
                    Text(formatTimeDifference(widget.post.created))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: convertUrlsToTextSpans(widget.post.described),
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
                      return Image.network(
                        widget.post.images[index].url,
                        fit: BoxFit.cover,
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.thumbsUp, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('Thích', style: TextStyle(fontSize: 14.0)),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('Bình luận', style: TextStyle(fontSize: 14.0)),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.share, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('Chia sẻ', style: TextStyle(fontSize: 14.0)),
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
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inDays < 365) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${(difference.inDays / 365).floor()} năm trước';
    }
  }

  List<TextSpan> convertUrlsToTextSpans(String text) {
    List<TextSpan> textSpans = [];
    RegExp urlRegex = RegExp(
        r'https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,}');

    Iterable<RegExpMatch> matches = urlRegex.allMatches(text);
    int lastEnd = 0;

    for (RegExpMatch match in matches) {
      if (match.start > lastEnd) {
        // Add non-URL text
        textSpans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: const TextStyle(color: Colors.black),
          ),
        );
      }

      // Add URL text
      textSpans.add(
        TextSpan(
          text: match.group(0),
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              // Handle URL tap (open in browser or perform custom action)
              // ignore: deprecated_member_use
              await launch(match.group(0)!); // Open URL in browser when tapped
            },
        ),
      );

      lastEnd = match.end;
    }

    // Add any remaining non-URL text
    if (lastEnd < text.length) {
      textSpans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: const TextStyle(color: Colors.black),
        ),
      );
    }

    return textSpans;
  }
}
