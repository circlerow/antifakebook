// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../application/friend_service.dart';
import '../../data/friend_repository.dart';
import '../../domain/friend.dart';

class ListBlockScreen extends StatefulWidget {
  const ListBlockScreen({super.key});

  @override
  _ListBlockScreenState createState() => _ListBlockScreenState();
}

class _ListBlockScreenState extends State<ListBlockScreen> {
  final FriendService _friendService =
      FriendService(friendRepository: FriendRepositoryImpl());
  List<Block> listBlock = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    dynamic body = {"index": "0", "count": "30"};
    final response = await _friendService.listBlock(body);
    setState(() {
      listBlock = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Users'),
      ),
      body: ListView.builder(
        itemCount: listBlock.length,
        itemBuilder: (context, index) {
          return _buildBlockedUserItem(listBlock[index]);
        },
      ),
    );
  }

  Widget _buildBlockedUserItem(Block user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text(user.name),
      subtitle: Text('ID: ${user.id}'),
      trailing: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'unblock',
            child: Text('Gỡ chặn'),
          ),
        ],
        onSelected: (value) {
          if (value == 'unblock') {
            _unblockUser(user.id);
          }
        },
      ),
    );
  }

  void _unblockUser(String userId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bỏ chặn người dùng'),
          content: const Text('Bạn có chắc muốn bỏ chặn người này'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final response = await _friendService.unBlockFriend(userId);
                if (response) {
                  Navigator.pop(context);
                  fetchData();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}