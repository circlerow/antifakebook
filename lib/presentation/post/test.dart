import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  File? _selectedVideo;

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedVideo = File(result.files.first.path!);
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_selectedVideo == null) {
      // Handle no video selected
      return;
    }

    String apiUrl = 'YOUR_UPLOAD_API_ENDPOINT';
    String accessToken = 'YOUR_ACCESS_TOKEN';

    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        _selectedVideo!.path,
        filename: 'video.mp4',
      ),
    });

    try {
      Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        onSendProgress: (int sent, int total) {
          // Handle upload progress
          double progress = sent / total;
          print('Upload progress: $progress');
        },
      );

      // Handle response from server
      print('Upload complete. Response: $response');
    } catch (error) {
      // Handle upload error
      print('Error during upload: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick Video'),
            ),
            const SizedBox(height: 16.0),
            if (_selectedVideo != null)
              Column(
                children: [
                  Text('Selected Video: ${_selectedVideo!.path}'),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _uploadVideo,
                    child: Text('Upload Video'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

