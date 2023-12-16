import 'package:flutter/material.dart';

import '../presentation/post/create_post.dart';

class WriteSomethingWidget extends StatelessWidget {
  const WriteSomethingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 17.0,
                      backgroundImage: AssetImage('assets/Mike Tyler.jpg'),
                    ),
                    Positioned(
                      right: 1.0,
                      bottom: 1.0,
                      child: CircleAvatar(
                        radius: 6.0,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreatePost()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    height: 40.0,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 234, 234),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text(
                      'What is on your mind?',
                      style: TextStyle(
                        fontSize: 16.0, // Kích thước chữ
                        fontWeight: FontWeight.w400, // Chữ đậm
                      ),
                    ),
                  ),
                ),
                Container(
                    child: Column(
                  children: <Widget>[
                    new Image.asset('assets/img/nav/photos.png',
                        width: 30.0, height: 30.0),
                    // SizedBox(height: 0),
                    const Text(
                      'photo',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )),
              ],
            ),
          ),
          //Divider(),
          /*Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.live_tv,
                      size: 20.0,
                      color: Colors.pink,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text('Live',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ],
                ),
                SizedBox(
                    height: 20,
                    child: VerticalDivider(color: Colors.grey[600])),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.photo_library,
                      size: 20.0,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 5.0),
                    Text('Photo',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ],
                ),
                Container(
                    height: 5, child: VerticalDivider(color: Colors.grey[600])),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.video_call,
                      size: 20.0,
                      color: Colors.purple,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text('Room',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ],
                )
              ],
            ),
          ) */
        ],
      ),
    );
  }
}
