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
    switch (noti.type) {
      case NotificationType.FriendRequest:
        return _FriendRequest(context, noti);
      case NotificationType.FriendAccept:
        return _FriendAccepted(context, noti);
      case NotificationType.PostFelt:
        return _PostFelt(context, noti);
      case NotificationType.PostAdded:
        return _PostAdded(context, noti);
      case NotificationType.PostUpdated:
        return _PostUpdated(context, noti);
      default:
        return _Default(context, noti);
    }
  }

  Widget _FriendAccepted(BuildContext context, Noti noti) {
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

    return _Custom(context, noti, content);
  }

  Widget _FriendRequest(BuildContext context, Noti noti) {
    dynamic content = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${noti.user!.username} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'đã gửi cho bạn lời mời kết bạn',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
    return _Custom(context, noti, content);
  }

  Widget _PostAdded(BuildContext context, Noti noti) {
    dynamic content = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${noti.user!.username} ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'vừa đăng một bài viết mới',
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

    return _Custom(context, noti, content);
  }

  Widget _PostUpdated(BuildContext context, Noti noti) {
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

    return _Custom(context, noti, content);
  }

  Widget _PostFelt(BuildContext context, Noti noti) {
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

    return _Custom(context, noti, content);
  }

  Widget _PostMarked(BuildContext context, Noti noti) {
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

    return _Custom(context, noti, content);
  }

  Widget _MarkCommented(BuildContext context, Noti noti) {
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

    return _Custom(context, noti, content);
  }

  Widget _VideoAdded(BuildContext context, Noti noti) {
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

    return _Custom(context, noti, content);
  }

  Widget _PostComment(BuildContext context, Noti noti) {
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

    return _Custom(context, noti, content);
  }

  Widget _Default(BuildContext context, Noti noti) {
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

  Widget _Custom(BuildContext context, Noti noti, Text content) {
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
                content,
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
