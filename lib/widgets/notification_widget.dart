import 'package:flutter/material.dart';
import 'package:flutter_application/domain/notification.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatelessWidget {
  final Noti noti;

  const NotificationWidget({super.key, required this.noti});

  @override
  Widget build(BuildContext context) {
    return _build(context, this.noti);
  }

  Widget _build(BuildContext context, Noti noti) {
    Color color = Colors.white.withOpacity(0.1);
    if (noti.read == "0") color = Colors.blue.withOpacity(0.1);

    switch (noti.type) {
      case NotificationType.FriendRequest:
        return _FriendRequest(context, noti, color);
      case NotificationType.FriendAccept:
        return _FriendAccepted(context, noti, color);
      case NotificationType.PostFelt:
        return _PostFelt(context, noti, color);
      case NotificationType.PostAdded:
        return _PostAdded(context, noti, color);
      case NotificationType.PostUpdated:
        return _PostUpdated(context, noti, color);
      case NotificationType.PostMarkd:
        return _PostMarked(context, noti, color);
      case NotificationType.VideoAdded:
        return _VideoAdded(context, noti, color);
      case NotificationType.PostCommented:
        return _PostComment(context, noti, color);
      default:
        return _Default(context, noti, color);
    }
  }

  Widget _FriendAccepted(BuildContext context, Noti noti, Color color) {
    Color color2 = Colors.blue;
    Widget icon = Icon(Icons.person_rounded, color: Colors.white);
    dynamic content = Text.rich(TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: '${noti.user!.username} ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: 'đã đồng ý lời mời kết bạn của bạn',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ],
    ));

    return _Custom(context, noti, content, color, color2, icon);
  }

  Widget _FriendRequest(BuildContext context, Noti noti, Color color) {
    Color color2 = Colors.blue;
    Widget icon = Icon(
      Icons.person_rounded,
      color: Colors.white,
    );
    dynamic content = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${noti.user!.username} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'đã gửi cho bạn lời mời kết bạn.',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
    return _Custom(context, noti, content, color, color2, icon);
  }

  Widget _PostAdded(BuildContext context, Noti noti, Color color) {
    Color color2 = Colors.blue;
    Widget icon = ImageIcon(
      AssetImage('assets/img/notification/book.png'),
      color: Colors.white,
      size: 20,
    );
    dynamic content = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${noti.user!.username} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'vừa đăng một bài viết mới: ',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          TextSpan(
              text: '${noti.post!.described}',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );

    return _Custom(context, noti, content, color, color2, icon);
  }

  Widget _PostUpdated(BuildContext context, Noti noti, Color color) {
    Color color2 = Colors.blue;
    Widget icon = Icon(Icons.person_rounded);
    dynamic content = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${noti.user!.username} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'vừa cập nhập bài viết ',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          TextSpan(
              text: '${noti.post!.described}',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );

    return _Custom(context, noti, content, color, color2, icon);
  }

  Widget _PostFelt(BuildContext context, Noti noti, Color color) {
    Color color2 = Colors.blue;
    Widget icon = ImageIcon(
      AssetImage('assets/img/notification/like.png'),
      color: Colors.white,
      size: 20,
    );
    String emote = "";
    if (noti.feel!.type == "0") emote = "thích bài viết của bạn: ";

    dynamic content = Text.rich(TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: '${noti.user!.username} ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: emote,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        TextSpan(
          text: '${noti.post!.described}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ));

    return _Custom(context, noti, content, color, color2, icon);
  }

  Widget _PostMarked(BuildContext context, Noti noti, Color color) {
    Color color2 = Colors.green;
    Widget icon = ImageIcon(
      AssetImage('assets/img/notification/white-cmt.png'),
      color: Colors.white,
      size: 16,
    );
    dynamic content = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${noti.user!.username} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'đã bình luận bài viết của bạn ',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          TextSpan(
              text: '${noti.post!.described}',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );

    return _Custom(context, noti, content, color, color2, icon);
  }

  Widget _MarkCommented(BuildContext context, Noti noti, Color color) {
    Color color2 = Colors.green;
    Widget icon = ImageIcon(
      AssetImage('assets/img/notification/white-cmt.png'),
      color: Colors.white,
      size: 16,
    );
    dynamic content = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${noti.user!.username} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ' đã trả lời bình luận của bạn ',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          TextSpan(
              text: '${noti.mark!.content}',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );

    return _Custom(context, noti, content, color, color2, icon);
  }

  Widget _VideoAdded(BuildContext context, Noti noti, Color color) {
    Color color2 = Colors.blue;
    Widget icon = ImageIcon(
      AssetImage('assets/img/notification/book.png'),
      color: Colors.white,
      size: 20,
    );
    dynamic content = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${noti.user!.username} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'vừa đăng một video ',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          TextSpan(
              text: '${noti.post!.described}',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );

    return _Custom(context, noti, content, color, color2, icon);
  }

  Widget _PostComment(BuildContext context, Noti noti, Color color) {
    Color color2 = Colors.green;
    Widget icon = ImageIcon(
      AssetImage('assets/img/notification/white-cmt.png'),
      color: Colors.white,
      size: 16,
    );
    dynamic content = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${noti.user!.username} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'đã bình luận bài viết của bạn ',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          TextSpan(
              text: '${noti.post!.described}',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );

    return _Custom(context, noti, content, color, color2, icon);
  }

  Widget _Default(BuildContext context, Noti noti, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(noti.avatar),
            radius: 28.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '${noti.user!.username} ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'defalut',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text("${timeAgo(noti.created)}",
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
              ],
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.more_horiz),
              Text(''),
            ],
          )
        ],
      ),
    );
  }

  Widget _Custom(BuildContext context, Noti noti, Text content, Color color,
      Color color2, Widget icon) {
    return Container(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10,
                    right: 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 60,
                          width: 60,
                          child: Stack(
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black54,
                                    width: 3,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(noti.avatar),
                                  radius: 40,
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                      padding: const EdgeInsets.all(0),
                                      alignment: Alignment.center,
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: color2,
                                      ),
                                      child: icon)),
                            ],
                          )),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            content,
                            Text("${timeAgo(noti.created)}",
                                style: const TextStyle(
                                    fontSize: 12.0, color: Colors.grey)),
                          ],
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.more_horiz),
                          Text(''),
                        ],
                      )
                    ],
                  ),
                ))));
  }

  String timeAgo(DateTime date) {
    final Duration difference = DateTime.now().difference(date);

    if (difference.inDays > 365) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else if (difference.inDays > 1) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inDays == 1) {
      return 'ngày hôm qua';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'vừa xong';
    }
  }
}
