import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/image_detail_page.dart';
import 'package:flutter_application/widgets/like_row_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({
    required this.post,
  });

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Xử lý sự kiện khi nhấn nút lùi lại
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút tìm kiếm
            },
          ),
        ],
        title: Text('Tên tác giả bài viết'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.author.avatar),
                  radius: 20.0,
                ),
                SizedBox(width: 7.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.post.author.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(formatTimeDifference(widget.post.created)),
                  ],
                ),
                Spacer(), // Để tạo khoảng trống giữa Column và PopupMenuButton
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text('Chỉnh sửa bài'),
                        value: 'edit',
                      ),
                      PopupMenuItem(
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
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: convertUrlsToTextSpans(widget.post.described),
              ),
            ),
            Container(
              width: double.infinity,
              child: widget.post.images.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0), // Khoảng cách dọc giữa các ảnh
                            child: Image.network(
                              widget.post.images[index].url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox.shrink(),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.thumbsUp,
                        size: 15.0, color: Colors.blue),
                    Text(' ${widget.post.feel}'),
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
                              title: Text(
                                'Comments',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
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
                                            Icon(FontAwesomeIcons.thumbsUp,
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
                                    SizedBox(
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
                                          return Text(
                                            "Comment",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                hintText: 'Write a comment...',
                                                fillColor: Colors.black),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.send),
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
                      child: Text('${widget.post.commentMark} comments  •  '),
                    )
                  ],
                ),
              ],
            ),
            Divider(height: 30.0),
            LikeRowWidget(),
            SizedBox(height: 20.0),
            Divider(height: 30.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10, // Số lượng bình luận
              itemBuilder: (context, index) {
                // Tạo widget cho từng bình luận
                return ListTile(
                  title: Text('Tiêu đề bình luận $index'),
                  subtitle: Text('Nội dung bình luận $index'),
                );
              },
            ),
          ],
        ),
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
