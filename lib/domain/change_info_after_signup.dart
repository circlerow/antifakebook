import 'dart:io';

class InfoAfter {
  final String userName;
  final File? avatar;

  InfoAfter({
    required this.userName,
    this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'avatar': avatar,
    };
  }
}
