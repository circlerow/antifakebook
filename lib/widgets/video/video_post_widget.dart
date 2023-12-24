import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/video/likeShareButton.dart';

import 'package:flutter_application/widgets/video/videoWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPostWidget extends StatefulWidget {
  final Post post;
  VideoPostWidget({required this.post});
  _VideoPostWidgetState createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(
                      2.0), // Khoảng cách giữa CircleAvatar và viền xám
                  decoration: BoxDecoration(
                    color: Colors.grey, // Màu của viền xám
                    shape: BoxShape.circle, // Đảm bảo viền là hình tròn
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.post.author.avatar),
                    radius: 20.0,
                  ),
                ),
                SizedBox(width: 7.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.post.author.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(formatTimeDifference(widget.post.created),
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: convertUrlsToTextSpans(widget.post.described),
              ),
            ),
          ),
          VideoPlayerWidget(url: widget.post.video.url),
          LikeShareButton(post: widget.post),
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
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(url as Uri);
              },
          ),
        );

        previousEnd = match.end;
      }

      if (previousEnd < text.length) {
        String remainingText = text.substring(previousEnd);
        textSpans.add(
          TextSpan(text: remainingText, style: TextStyle(color: Colors.black)),
        );
      }
    } else {
      textSpans.add(
        TextSpan(text: text, style: TextStyle(color: Colors.black)),
      );
    }

    return textSpans;
  }
}
