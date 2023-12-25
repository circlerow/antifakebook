import 'package:flutter/material.dart';
import 'package:flutter_application/application/friend_service.dart';
import 'package:flutter_application/data/friend_repository.dart';
import 'package:flutter_application/domain/friend.dart';
import 'package:flutter_application/presentation/friend/FriendInfo.dart';

class FriendsView extends StatefulWidget {
  final String userId;
  final bool isListFriend;
  const FriendsView(
      {super.key, required this.isListFriend, required this.userId});

  @override
  FriendsViewPage createState() => FriendsViewPage();
}

class FriendsViewPage extends State<FriendsView> {
  String title = "Danh sách bạn bè";
  bool isLoading = false;
  FriendService friendService =
      FriendService(friendRepository: FriendRepositoryImpl());
  late Future<void> _dataFuture;
  late List<Friend> friends = [];
  late String total;
  int currentPage = 0;
  List<bool> isFriendRequestSent = List.filled(10000, false);
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<void> fetchData() async {
    if (!isLoading) {
      setState(() {
      });
    }

    Map<String, dynamic> fetchedPosts =
        await friendService.getUserFriends("$currentPage", "20", widget.userId);

    List<Friend> fetchFriendSuggested = await friendService
        .getSuggestedFriends({"index": "$currentPage", "count": "20"});

    setState(() {
      title = widget.isListFriend
          ? "Danh sách bạn bè"
          : "Những người bạn có thể biết";
      if (widget.isListFriend) {
        friends = fetchedPosts['friends'];
        total = fetchedPosts['total'];
      } else {
        friends = fetchFriendSuggested;
        total = '0';
      }
      currentPage += friends.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Dữ liệu đã tải xong, hiển thị giao diện
          return buildContent(context);
        } else if (snapshot.hasError) {
          // Xử lý lỗi nếu có
          return buildErrorWidget(snapshot.error.toString());
        } else {
          // Hiển thị màn hình loading trong quá trình tải dữ liệu
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget buildContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  for (Friend friend in friends)
                    Column(
                      children: <Widget>[FriendItem(friend)],
                    ),
                  if (isLoading) const CircularProgressIndicator(),
                ],
              ),
            )));
  }

  Widget FriendItem(Friend friend) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FriendInfo(
                            friendId: friend.id,
                          )),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(friend.avatar.isNotEmpty
                    ? friend.avatar
                    : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"),
                radius: 40.0,
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  friend.username.isNotEmpty ? friend.username : "(No Name)",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: <Widget>[
                    if (!isFriendRequestSent[int.tryParse(friend.id)!] &&
                        !widget.isListFriend)
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              bool sendRequest = await friendService
                                  .setRequestFriend(friend.id);
                              if (sendRequest) {
                                setState(() {
                                  isFriendRequestSent[
                                      int.tryParse(friend.id)!] = true;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: const Text(
                                'Thêm bạn bè',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: const Text(
                                'Gỡ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (!widget.isListFriend)
                      const Text(
                        'Đã gửi lời mời kết bạn',
                        style: TextStyle(fontSize: 15.0),
                      )
                    else
                      Text(
                        '${friend.sameFriends} bạn chung',
                        style: TextStyle(fontSize: 15.0),
                      ),
                  ],
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget buildErrorWidget(String error) {
    // Giao diện khi có lỗi
    return Scaffold(
      body: Center(
        child: Text("Error: $error"),
      ),
    );
  }

  Widget buildLoadingWidget() {
    // Giao diện loading
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
