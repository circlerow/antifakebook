import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/application/comment_service.dart';
import 'package:flutter_application/data/comment_repository.dart';
import 'package:flutter_application/domain/comment.dart';
import 'package:flutter_application/application/post_service.dart';
import 'package:flutter_application/data/post_repository.dart';
import 'package:flutter_application/domain/feel.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:flutter_application/widgets/image_detail_page.dart';
import 'package:flutter_application/widgets/like_row_widget.dart';
import 'package:flutter_application/widgets/post/comment_widget.dart';
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
  GlobalKey<CommentWidgetState> commentKey = GlobalKey<CommentWidgetState>();

  late CommentService service;
  bool _isChanged = false;
  bool _comment = false;
  String name = "";
  String id = "";
  TextEditingController _textEditingController = TextEditingController();
  late FocusNode _focusNode = FocusNode();
  late Widget commentWidget = Container();
  void _updateState(
    bool value,
    String nameUsser,
    String idMark,
  ) {
    setState(() {
      _isChanged = value;
      _comment = value;
      print("Name = " + nameUsser);
      name = nameUsser;
      id = idMark;
    });
  }

  @override
  void initState() {
    super.initState();
    service = CommentService(repo: CommentRepository());
    getComments();
  }

  Future<void> getComments() async {
    print("ID = " + widget.post.id);
    List<Comment> fetchedComments =
        await service.getMarkComment(int.parse(widget.post.id), 10);
    widget.post.comments = fetchedComments;
    setState(() {
      commentWidget = CommentWidget(
          key: commentKey,
          post: widget.post,
          onChanged: _updateState,
          comments: widget.post.comments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        title: Text(
          widget.post.author.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.post.author.avatar),
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
                ),
                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: convertUrlsToTextSpans(widget.post.described),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  child: widget.post.images.isNotEmpty
                      ? Column(
                          children: [
                            for (int i = 0;
                                i < widget.post.images.length;
                                i++) ...[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageDetailPage(
                                        imageUrls: widget.post.images,
                                        initialIndex: i,
                                      ),
                                    ),
                                  );
                                },
                                child:
                                    // padding: EdgeInsets.symmetric(
                                    //     vertical:
                                    //         1.0), // Khoảng cách dọc giữa các ảnh
                                    Image.network(
                                  widget.post.images[i].url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (i !=
                                  widget.post.images.length -
                                      1) // Kiểm tra trước khi thêm đường ngăn cách
                                Divider(
                                  color: Colors.grey,
                                  height: 20.0,
                                  // thickness: 5.0,
                                ),
                            ],
                          ],
                        )
                      : SizedBox.shrink(),
                ),
                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            _showDialogLikeDetail(context, widget.post.id);
                          },
                          child:
                          Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.thumbsUp,
                                  size: 15.0, color: Colors.blue),
                              Text(' ${widget.post.feel}'),
                            ],
                          ),
                        ),
                      Row(
                        children: <Widget>[
                          Text('${widget.post.commentMark} comments  •  '),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 10.0),
                LikeRowWidget(),
                Divider(height: 10.0),
                // CommentWidget(
                //   post: widget.post,
                //   onChanged: _updateState,
                // ),
                commentWidget
              ]),
            ),
          ),
          Divider(height: 1.0),
          if (_comment)
            Container(
                margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'phản hồi ',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ])),
                    Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(6.0),
                      onTap: () {
                        setState(() {
                          _comment = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'hủy',
                          style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                )),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300], // Màu nền xám của vùng chứa
              borderRadius: BorderRadius.circular(15), // Viền bo cong 10 độ
            ),
            margin: EdgeInsets.fromLTRB(16, 4, 16, 16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: 'Viết bình luận...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      onPressed: () async {
                        String comment = _textEditingController.text;
                        print('Nội dung bình luận: $comment');
                        _textEditingController.clear();
                        _focusNode.unfocus();

                        if (_comment == false) {
                          await widget.post
                              .addMark(service, widget.post.id, comment);
                          commentKey.currentState!
                              .updateState(widget.post.comments);
                          //  commentWidget = Container();
                          setState(() async {
                            // commentKey.currentState!
                            //     .updateState(widget.post.comments);
                            _comment = false;
                          });
                        } else {
                          await widget.post
                              .addComment(service, widget.post.id, id, comment);
                          //    commentWidget = Container();
                          commentKey.currentState!
                              .updateState(widget.post.comments);
                          setState(() {
                            // commentKey.currentState!
                            //     .updateState(widget.post.comments);
                            _comment = false;
                          });
                        }
                      },
                      icon: Icon(Icons.send), // Biểu tượng gửi
                    ),
                  ],
                )
              ],
            ),
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

void _showDialogLikeDetail(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<FeelData>>(
        future: _fetchData(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading indicator or any placeholder
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Use the fetched data here
            List<FeelData> feels = snapshot.data!;
            return AlertDialog(
              title: Text('Những người đã thích'),
              insetPadding: EdgeInsets.only(bottom: 0, right: 0, left: 0, top: MediaQuery.of(context).size.height/3),
              content: Container(
                  height : MediaQuery.of(context).size.height/3*2,
                  width : MediaQuery.of(context).size.width,
                  child:
              SingleChildScrollView(
                child:
                Column(
                  children: [
                    // Display your data in the AlertDialog
                    for (var feel in feels)
                      Padding(padding: EdgeInsets.only(bottom: 10),
                      child:
                        Row(
                        children: <Widget>[
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(feel.feel.user.avatar),
                                radius: 20.0,
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white, // Màu nền trắng
                                  ),
                                  padding: EdgeInsets.all(4.0), // Khoảng cách giữa biểu tượng và viền nền
                                  child: Icon(
                                    feel.feel.type == "0" ? FontAwesomeIcons.thumbsUp : FontAwesomeIcons.heart,
                                    size: 15.0,
                                    color: feel.feel.type == "0" ? Colors.blue : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 8.0), // Khoảng cách giữa Stack và Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(feel.feel.user.name),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ),
            );
          } else {
            return Text('No data available');
          }
        },
      );
    },
  );
}

Future<List<FeelData>> _fetchData(String id) async {
  PostService postService = PostService(postRepository: PostRepositoryImpl());
  return await postService.getListFeels({"id": id, "index": "0", "count": "10"});
}
