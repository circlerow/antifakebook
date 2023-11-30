import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/signup/hoTen.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController _postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 28.0,
                backgroundImage: AssetImage('assets/Mike Tyler.jpg'),
              ),
              title: Text("Username Here"),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          foregroundColor: Color.fromARGB(255, 0, 0, 0),
                          side: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 202, 202, 202),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.group),
                        label: Row(
                          children: [
                            Text('Friends'),
                            Expanded(
                              child: Icon(
                                Icons.arrow_drop_down,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 180,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              child: TextFormField(
                controller: _postTextController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'What\'s on your mind?',
                  contentPadding: EdgeInsets.only(top: 0, left: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Thực hiện xử lý khi người dùng nhấn nút đăng bài
                _createPost();
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm này thực hiện xử lý khi người dùng nhấn nút "Post"
  void _createPost() {
    // Lấy nội dung bài đăng từ TextEditingController
    String postContent = _postTextController.text;

    // Ở đây có thể thực hiện logic để đăng bài lên Facebook, ví dụ:
    // FacebookService.createPost(postContent);

    // Sau khi đăng bài xong, có thể thực hiện các hành động khác, ví dụ:
    // Hiển thị thông báo bài đăng thành công, quay về màn hình trước đó, ...

    // Ví dụ thông báo khi đăng bài thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Post created: $postContent'),
      ),
    );
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi không sử dụng TextEditingController nữa
    _postTextController.dispose();
    super.dispose();
  }
}
