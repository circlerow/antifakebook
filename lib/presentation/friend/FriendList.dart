import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/domain/friend.dart';
import 'package:flutter_application/presentation/friend/FriendInfo.dart';

class FriendList extends StatelessWidget {
  final List<Friend> friends;
  final String total;

  FriendList({super.key, required this.friends, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Bạn bè',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6.0),
                  Text('$total bạn bè',
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                ],
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width /
                2 *
                setHeightListFriend(friends.length),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Số cột trên mỗi hàng
                  crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
                  mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
                  childAspectRatio: 2 / 3,
                ),
                itemCount: friends.length,
                itemBuilder: (BuildContext context, int index) {
                  Friend friend = friends[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FriendInfo(
                                    friendId: friend.id,
                                  )),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.width / 3 - 20,
                            width: MediaQuery.of(context).size.width / 3,
                            padding: EdgeInsets.all(1),
                            child: CachedNetworkImage(
                              imageUrl: friend.avatar,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Divider(height: 0.5),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 6,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              friend.username,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ));
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: const Center(
              child: Text('See All Friends',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ),
          ),
        ],
      ),
    );
  }

  int setHeightListFriend(int length) {
    if (length == 0)
      return 0;
    else if (length == 3)
      return 1;
    else if (length == 6) return 2;
    return length ~/ 3 + 1;
  }
}
