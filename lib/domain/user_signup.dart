class UserSignup {
  final String email;
  final String password;
  final String uuid;

  UserSignup({
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
