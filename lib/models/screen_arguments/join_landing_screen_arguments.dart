class JoinLandingScreenArguments {
  final String? sessionCode;
  final String? password;
  final String username;
  final bool reconnect;

  JoinLandingScreenArguments({
    this.sessionCode,
    this.password,
    this.username = 'Unknown',
    this.reconnect = false,
  });
}
