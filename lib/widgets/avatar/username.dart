import 'package:flutter/material.dart';
import 'package:flutter_application/controller/profileController.dart';

class UsernameWidget extends StatefulWidget {
  const UsernameWidget({Key? key}) : super(key: key);

  @override
  _UsernameWidgetState createState() => _UsernameWidgetState();
}

class _UsernameWidgetState extends State<UsernameWidget> {
  late Future<String> _username;

  @override
  void initState() {
    _username = UserController.getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _username,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('mock name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String username = snapshot.data ?? '';
          return _buildWidgetWithAvatarLink(context, username);
        }
      },
    );
  }

  Widget _buildWidgetWithAvatarLink(BuildContext context, String username) {
    return Text(username,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0));
  }
}
