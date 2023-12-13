// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/domain/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../application/user_service.dart';
import '../../data/user_repository.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  late Future<void> _dataFuture;
  final TextEditingController _postTextController = TextEditingController();
  late User user;
  final List<XFile> _selectedImages = [];
  final List<XFile> _selectedImagesVideos = [];
  final List<String> _selectedVideos = [];

  @override
  void initState() {
    super.initState();
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
    if (_selectedImages.length >= 4) {
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
    XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImages.add(pickedImage);
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? pickedVideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (pickedVideo != null) {
      final thumbnailPath = await createThumbnail(pickedVideo.path);
      setState(() {
        _selectedVideos.add(pickedVideo.path); // Store the video path
        _selectedImagesVideos
            .add(XFile(thumbnailPath!)); // Convert to XFile and store
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
        title: const Text('Tạo bài viết'),
        actions: [
          InkResponse(
            onTap: () {
              _createPost();
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: const Text(
                'Đăng',
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
              title: Text(
                user.username,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    SizedBox(
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
                    height: ((_selectedImages.length / 2).ceil() * 180),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount:
                          _selectedImages.length + _selectedVideos.length,
                      itemBuilder: (context, index) {
                        if (index < _selectedImages.length) {
                          return _buildImageItem(index);
                        } else {
                          final videoIndex = index - _selectedImages.length;
                          return _buildVideoItem(videoIndex);
                        }
                      },
                    ),
                  ),
                  Container(
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
                            onPressed: _pickImage,
                            icon: const Row(
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  'Add Image',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                            onPressed: _pickVideo,
                            icon: const Row(
                              children: [
                                Icon(
                                  Icons.ondemand_video,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  'Add Video',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                            onPressed: () {},
                            icon: const Row(
                              children: [
                                Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Colors.yellow,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  'Add Status',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                File(_selectedImages[index].path),
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
                _selectedImages.removeAt(index);
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
                    File(_selectedImagesVideos[videoIndex].path),
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
                _selectedImagesVideos.removeAt(videoIndex);
                _selectedVideos.removeAt(videoIndex);
              });
            },
          ),
        ),
      ],
    );
  }

  void _createPost() {
    String postContent = _postTextController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Post created: $postContent'),
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
