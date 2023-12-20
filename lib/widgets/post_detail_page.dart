import 'package:flutter/material.dart';
import 'package:flutter_application/domain/post.dart';

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
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Nội dung bài viết'),
            ),
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
