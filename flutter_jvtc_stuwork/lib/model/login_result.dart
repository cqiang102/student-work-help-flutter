class LoginResult {
  bool status;
  String message;
  String token;

  LoginResult({this.status, this.message, this.token});

  @override
  String toString() {
    return 'LoginResult{status: $status, message: $message, token: $token}';
  }
}
