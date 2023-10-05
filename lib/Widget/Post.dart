import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  // This widget is the root of your application.
  String userImage = "../assets/images/avatar.jpeg";
  String username, caption;
  String timeAgo = "time";
  String like = "1";
  String comments = "2";
  String shares = "3";
  String imageURL = "../assets/images/content.jpeg";
  PostScreen({super.key, required this.username, required this.caption});

  @override
  Widget build(BuildContext context) {
    return PostScreenPage(
      userImage: this.userImage,
      username: this.username,
      caption: this.caption,
      timeAgo: this.timeAgo,
      imageURL: this.imageURL,
    );
  }
}

class PostScreenPage extends StatefulWidget {
  String username, caption, timeAgo, userImage, imageURL;
  PostScreenPage(
      {super.key,
      required this.userImage,
      required this.username,
      required this.timeAgo,
      required this.caption,
      required this.imageURL});
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(
                    profileImage: widget.userImage,
                    username: widget.username,
                    timeAgo: widget.timeAgo,
                  ),
                  const SizedBox(height: 4.0),
                  Text(widget.caption),
                  widget.imageURL != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            widget.imageURL != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(widget.imageURL),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final String profileImage;
  final String username;
  final String timeAgo;
  const _PostHeader({
    super.key,
    required this.profileImage,
    required this.username,
    required this.timeAgo,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AvatarImage(
          profileAvatarImage: profileImage,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${timeAgo} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}

class _AvatarImage extends StatelessWidget {
  final String profileAvatarImage;

  const _AvatarImage({
    super.key,
    required this.profileAvatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Stack(children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[200],
          backgroundImage: AssetImage(profileAvatarImage),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(
            height: 15.0,
            width: 15.0,
            decoration: BoxDecoration(
              color: Color(0xFF50b525),
              shape: BoxShape.circle,
              border: Border.all(
                width: 2.0,
                color: Colors.white,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
