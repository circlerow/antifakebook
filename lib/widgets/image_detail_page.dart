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

class ImageDetailPage extends StatefulWidget {
  final List imageUrls;
  final int initialIndex;

  const ImageDetailPage({required this.imageUrls, this.initialIndex = 0});

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.imageUrls.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Center(
              child: Image.network(
                widget.imageUrls[index].url,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}
