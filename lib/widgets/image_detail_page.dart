import 'package:flutter/material.dart';

// class ImageListPage extends StatefulWidget {
//   @override
//   _ImageListPageState createState() => _ImageListPageState();
// }

// class _ImageListPageState extends State<ImageListPage> {
//   List<String> imageUrls = [];

//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image List'),
//       ),
//       body: PageView.builder(
//         itemCount: imageUrls.length,
//         controller: PageController(initialPage: currentIndex),
//         onPageChanged: (int index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         itemBuilder: (BuildContext context, int index) {
//           return ImageDetailPage(imageUrl: imageUrls[index]);
//         },
//       ),
//     );
//   }
// }

class ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  const ImageDetailPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
