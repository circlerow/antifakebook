import 'package:flutter/material.dart';
import 'package:flutter_application/Widget/Post.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // mock data
    final data = [
      {"username": "test1", "caption": "caption1"},
      {"username": "test2", "caption": "caption2"}
    ];
    List<PostScreen> posts = data
        .map((json) =>
            PostScreen(username: json['username']!, caption: json['caption']!))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return posts[index];
        },
      ),
    );
  }
}
