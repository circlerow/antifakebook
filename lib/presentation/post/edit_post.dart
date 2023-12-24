import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../application/post_service.dart';
import '../../application/user_service.dart';
import '../../data/post_repository.dart';
import '../../data/user_repository.dart';
import '../../domain/post.dart';
import '../home/home.dart';
import 'status.dart';

class EditPost extends StatefulWidget {
  final Post post;

  const EditPost({
    super.key,
    required this.post,
  });

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  late Future<void> _dataFuture;
  TextEditingController _postTextController = TextEditingController();
  late User user;
  late String status = widget.post.feel;
  List<File>? _selectedImages;
  List<File>? _selectedImagesVideos;
  List<String>? _selectedImagesVideosUrl;
  File? _selectedVideos;
  List<int>? temp;
  List<int> deleteImage = [];
  final PostService postService =
      PostService(postRepository: PostRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _postTextController = TextEditingController(text: widget.post.described);
    status = widget.post.state;
    _selectedImages ??= [];
    _selectedImagesVideosUrl = widget.post.images.map((e) => e.url).toList();
    temp =
        List.generate(_selectedImagesVideosUrl!.length, (index) => index + 1);
    _dataFuture = fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id')!;
    UserService userService = UserService(userRepository: UserRepositoryImpl());
    User fetchedUser = await userService.getUserInfo(userId);
    setState(() {
      user = fetchedUser;
    });
  }

  Future<void> _pickImage() async {
    if (_selectedImages != null) {
      if (_selectedImages!.length >= 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Chỉ được chọn tối đa 4 ảnh.'),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ),
        );
        return;
      }
    }
    XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImages?.add(File(pickedImage.path));
      });
    }
  }

  Future<void> _pickVideo() async {
    if (_selectedImagesVideos != null) {
      if (_selectedImagesVideos!.length == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Chỉ được chọn tối đa 1 video.'),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ),
        );
        return;
      }
    }
    XFile? pickedVideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    _selectedImagesVideos ??= [];
    if (pickedVideo != null) {
      final thumbnailPath = await createThumbnail(pickedVideo.path);
      setState(() {
        _selectedVideos = File(pickedVideo.path);
        _selectedImagesVideos?.add(File(thumbnailPath!));
      });
    }
  }

  Future<String?> createThumbnail(String videoPath) async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
    );
    return thumbnail;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildContent(context);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error.toString());
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa bài viết'),
        actions: [
          InkResponse(
            onTap: () async {
              await _editPost();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: const Text(
                'Chỉnh sửa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 28.0,
                backgroundImage: NetworkImage(user.avatar.isNotEmpty
                    ? user.avatar
                    : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"),
              ),
              title: RichText(
                text: TextSpan(
                  text: user.username,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    if (status.isNotEmpty)
                      TextSpan(
                        text: ' -  Đang cảm thấy $status',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 130.0,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          side: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 202, 202, 202),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.public),
                        label: const Row(
                          children: [
                            Text('Public'),
                            Spacer(),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _postTextController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Bạn đang nghĩ gì?',
                      contentPadding: EdgeInsets.only(top: 20, left: 0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: ((((_selectedImages?.length) ?? 0) +
                                    ((_selectedImagesVideos?.length) ?? 0) +
                                    (_selectedImagesVideosUrl?.length ?? 0)) /
                                2)
                            .ceil() *
                        180,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: (_selectedImagesVideosUrl?.length ?? 0) +
                          (_selectedImages?.length ?? 0) +
                          (_selectedImagesVideos?.length ?? 0),
                      itemBuilder: (context, index) {
                        if (index < (_selectedImages?.length ?? 0)) {
                          return _buildImageItem(index);
                        } else if (index <
                            (_selectedImages?.length ?? 0) +
                                (_selectedImagesVideosUrl?.length ?? 0)) {
                          return _buildImageUrlItem(
                              index - (_selectedImages?.length ?? 0));
                        } else {
                          return _buildVideoItem(index -
                              ((_selectedImages?.length ?? 0) +
                                  (_selectedImagesVideosUrl?.length ?? 0)));
                        }
                      },
                    ),
                  ),
                  CustomIconButton(
                    icon: Icons.image_outlined,
                    text: 'Add Image',
                    iconColor: Colors.green,
                    textColor: Colors.blue,
                    onPressed: _pickImage,
                  ),
                  CustomIconButton(
                    icon: Icons.ondemand_video,
                    text: 'Add Video',
                    iconColor: Colors.blue,
                    textColor: Colors.blue,
                    onPressed: _pickVideo,
                  ),
                  CustomIconButton(
                    icon: Icons.emoji_emotions_outlined,
                    text: 'Add Status',
                    iconColor: Colors.yellow,
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatusScreen(
                            initialStatus: status,
                            onStatusChanged: (newStatus, icon) {
                              setState(() {
                                status = newStatus;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      )),
    );
  }

  Widget _buildImageItem(int index) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                File(_selectedImages![index].path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _selectedImages!.removeAt(index);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImageUrlItem(int index) {
    String imageUrl = _selectedImagesVideosUrl![index];
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _selectedImagesVideosUrl!.removeAt(index);
                deleteImage.add(temp![index]);
                temp!.removeAt(index);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoItem(int index) {
    final videoIndex = index;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(
                children: [
                  Image.file(
                    File(_selectedImagesVideos![index].path),
                    fit: BoxFit.cover,
                  ),
                  const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _selectedImagesVideos!.removeAt(videoIndex);
              });
            },
          ),
        ),
      ],
    );
  }

  Future<void> _editPost() async {
    String described = _postTextController.text;

    String deleteList = deleteImage.join(', ');

    dynamic res = await postService.editPost(PostEdit(
        id: widget.post.id,
        image: _selectedImages,
        video: _selectedVideos,
        described: described,
        status: status,
        autoAccept: '1',
        imageDelete: deleteList));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Post created: $described'),
      ),
    );
  }

  Widget buildErrorWidget(String error) {
    return Scaffold(
      body: Center(
        child: Text("Error: $error"),
      ),
    );
  }

  Widget buildLoadingWidget() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _postTextController.dispose();
    super.dispose();
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: onPressed,
              icon: Row(
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
