import 'package:flutter/material.dart';
import 'package:flutter_application/application/user_service.dart';
import 'package:flutter_application/data/user_repository.dart';
import 'package:flutter_application/domain/user.dart';

class UserProfile extends StatefulWidget {
  final int userId;

  const UserProfile({super.key, required this.userId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<User> futureUser;
  late UserService userService;

  @override
  void initState() {
    super.initState();
    userService = UserService(userRepository: UserRepositoryImpl());
    futureUser = userService.getUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Name: ${snapshot.data!.name}'),
                  Text('Email: ${snapshot.data!.email}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
