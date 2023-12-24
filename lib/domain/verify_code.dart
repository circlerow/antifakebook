class VerifyCode {
  final String email;
  final String verifyCode;

  VerifyCode({
    required this.email,
    required this.verifyCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code_verify': verifyCode,
    };
  }
}
