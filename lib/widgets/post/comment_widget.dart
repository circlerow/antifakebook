import 'package:flutter/material.dart';
import 'package:flutter_application/application/comment_service.dart';
import 'package:flutter_application/data/comment_repository.dart';
import 'package:flutter_application/domain/comment.dart';
import 'package:flutter_application/domain/post.dart';
import 'package:intl/intl.dart';

class CommentWidget extends StatefulWidget {
  final Post post;
  final List<Comment> comments;
  final Function(bool, String, String) onChanged;
  CommentWidget({
    Key? key,
    required this.post,
    required this.onChanged,
    required this.comments,
  }) : super(key: key);

  @override
  CommentWidgetState createState() => CommentWidgetState();
}

class CommentWidgetState extends State<CommentWidget> {
  late List<Comment> comments = [];
  late CommentService service;

  void updateState(List<Comment> newComments) {
    setState(() {
      comments = newComments;
    });
  }

  @override
  void initState() {
    super.initState();
    service = CommentService(repo: CommentRepository());
    getComments();
  }

  Future<void> getComments() async {
    // print("ID = " + widget.post.id);
    // List<Comment> fetchedComments =
    //     await service.getMarkComment(int.parse(widget.post.id), 10);
    setState(() {
      comments = widget.comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    return ListView.builder(
      controller: _controller,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        Comment comment = comments[index];

        return Container(
          // constraints:
          //     BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 7.0),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400],
                        ),
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(comment.poster.avatar),
                        ),
                      )),
                  const SizedBox(width: 15.0),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: comment.poster.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                comment.mark_content,
                                overflow: TextOverflow.clip,
                                maxLines: 10,
                                softWrap: true,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                        Row(children: [
                          Text(
                            timeAgo(comment.createAt),
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(6.0),
                            onTap: () {
                              widget.onChanged(
                                  true, comment.poster.name, comment.id);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Phản hồi',
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ]),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  )
                ],
              ),
              if (comment.childComment.isNotEmpty)
                Column(
                  children: comment.childComment.map((childComment) {
                    return Container(
                      margin: EdgeInsets.only(left: 60),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[400],
                                      ),
                                      child: CircleAvatar(
                                        radius: 20.0,
                                        backgroundImage: NetworkImage(
                                            childComment.poster.avatar),
                                      ),
                                    )),
                                const SizedBox(width: 7.0),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 0),
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 20, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.grey[200],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: [
                                                  TextSpan(
                                                    text: childComment
                                                        .poster.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5.0),
                                            Text(
                                              childComment.content,
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                              softWrap: true,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5.0),
                                          ],
                                        ),
                                      ),
                                      Row(children: [
                                        Text(
                                          timeAgo(comment.createAt),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              'Phản hồi',
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                          ]),
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  String timeAgo(DateTime date) {
    final Duration difference = DateTime.now().difference(date);

    if (difference.inDays > 365) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else if (difference.inDays > 1) {
      return '${difference.inDays} ngày ';
    } else if (difference.inDays == 1) {
      return '1 ngày';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} giờ ';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} phút ';
    } else {
      return 'vừa xong';
    }
  }
}
