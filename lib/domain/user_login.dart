class UserLogin {
  final String email;
  final String password;
  final String uuid;

  UserLogin({
    required this.email,
    required this.password,
    required this.uuid,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'uuid': uuid
    };
  }

}
